#####
# Locals
#####

locals {
  application_version = var.application_version
  labels = {
    name       = "redis"
    component  = "exporter"
    part-of    = "monitoring"
    managed-by = "terraform"
    version    = local.application_version
  }


  default_resource_requests = {
    cpu    = "100m"
    memory = "256Mi"
  }

  default_resource_limits = {
    cpu    = "1000m"
    memory = "1Gi"
  }
}

#####
# Randoms
#####

resource "random_string" "selector" {
  special = false
  upper   = false
  number  = false
  length  = 8
}

#####
# Statefulset
#####

resource "kubernetes_stateful_set" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name      = var.stateful_set_name
    namespace = var.namespace
    annotations = merge(
      local.annotations,
      var.annotations,
      var.stateful_set_annotations
    )
    labels = merge(
      {
        instance  = var.stateful_set_name
        component = "application"
      },
      local.labels,
      var.labels,
      var.stateful_set_labels
    )
  }

  spec {
    replicas     = var.replicas
    service_name = element(concat(kubernetes_service.this.*.metadata.0.name, list("")), 0)

    update_strategy {
      type = "RollingUpdate"
    }

    selector {
      match_labels = {
        selector = "redis-${element(concat(random_string.selector.*.result, list("")), 0)}"
      }
    }


    template {
      metadata {
        annotations = merge(
          var.master_pod_annotations,
          local.annotations,
          var.annotations,
          var.stateful_set_template_annotations
        )
        labels = merge(
          {
            role      = "master"
            instance  = var.stateful_set_name
            component = "application"
            selector  = "redis-${element(concat(random_string.selector.*.result, list("")), 0)}"
          },
          local.labels,
          var.labels,
          var.stateful_set_template_labels
        )
      }

      spec {

        security_context {
          fs_group    = var.master_security_context["fs_group"]
          run_as_user = var.master_security_context["run_as_user"]
        }

        node_selector = var.kubernetes_node_selector


        automount_service_account_token = var.stateful_set_automount_service_account_token
        service_account_name            = kubernetes_service_account.this.*.metadata.0.name


        container {
          name              = "redis"
          image             = var.redis_image
          image_pull_policy = var.redis_image_pull_policy
          args              = var.master_args

          env_from {
            config_map_ref {
              name = kubernetes_config_map.this.*.metadata.0.name
            }
          }

          env_from {
            secret_ref {
              name = kubernetes_secret.this.*.metadata.0.name
            }
          }


          resources {
            requests = [merge(local.default_resource_requests, var.master_resource_requests)]

            limits = [merge(local.default_resource_limits, var.master_resource_limits)]
          }


          port {
            container_port = var.master_port
            protocol       = "TCP"
            name           = "http"
          }

          liveness_probe {
            initial_delay_seconds = var.master_liveness_probe["initial_delay_seconds"]
            period_seconds        = var.master_liveness_probe["period_seconds"]
            timeout_seconds       = var.master_liveness_probe["timeout_seconds"]
            success_threshold     = var.master_liveness_probe["success_threshold"]
            failure_threshold     = var.master_liveness_probe["failure_threshold"]

            exec {
              command = [
                "redis-cli",
                "ping",
              ]
            }
          }

          readiness_probe {
            initial_delay_seconds = var.master_readiness_probe["initial_delay_seconds"]
            period_seconds        = var.master_readiness_probe["period_seconds"]
            timeout_seconds       = var.master_readiness_probe["timeout_seconds"]
            success_threshold     = var.master_readiness_probe["success_threshold"]
            failure_threshold     = var.master_readiness_probe["failure_threshold"]

            exec {
              command = [
                "redis-cli",
                "ping",
              ]
            }
          }


          dynamic "volume_mount" {
            for_each = var.stateful_set_volume_claim_template_enabled ? [1] : []

            content {
              name       = var.stateful_set_volume_claim_template_name
              mount_path = "/var/redis"
              sub_path   = ""
            }
          }
        }
      }
    }

    dynamic "volume_claim_template" {
      for_each = var.stateful_set_volume_claim_template_enabled ? [1] : []

      content {
        metadata {
          name      = var.stateful_set_volume_claim_template_name
          namespace = var.namespace
          annotations = merge(
            local.annotations,
            var.annotations,
            var.stateful_set_volume_claim_template_annotations
          )
          labels = merge(
            {
              instance  = var.stateful_set_volume_claim_template_name
              component = "storage"
            },
            local.labels,
            var.labels,
            var.stateful_set_volume_claim_template_labels
          )
        }

        spec {
          access_modes       = ["ReadWriteOnce"]
          storage_class_name = var.stateful_set_volume_claim_template_storage_class
          resources {
            requests = {
              storage = var.stateful_set_volume_claim_template_requests_storage
            }
          }
        }
      }
    }
  }

  # NOTE: This is needed because while documentation suggests that all labels can be changed, it seems that on VolumeClaimTemplates it is not possible to change them.
  # I create https://github.com/kubernetes/kubernetes/issues/93115 for this specific problem.
  lifecycle {
    ignore_changes = [
      spec[0].volume_claim_template[0].metadata[0].labels,
      spec[0].volume_claim_template[0].metadata[0].annotations,
    ]
  }
}

#####
# ConfigMap
#####

resource "kubernetes_config_map" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name      = var.config_map_name
    namespace = var.namespace
    annotations = merge(
      var.annotations,
      var.config_map_annotations
    )
    labels = merge(
      {
        instance = var.config_map_name
      },
      local.labels,
      var.labels,
      var.config_map_labels
    )
  }

  data = {
    "servicenow.yml" = var.configuration
  }
}

#####
# Secret
#####

resource "kubernetes_secret" "this" {


  metadata {
    name      = var.secret_name
    namespace = var.namespace
    annotations = merge(
      var.annotations,
      var.secret_annotations
    )
    labels = merge(
      {
        "instance" = var.secret_name
      },
      local.labels,
      var.labels,
      var.secret_labels
    )
  }

  data = var.redis_secrets

  type = "Opaque"
}



#####
# Service
#####

resource "kubernetes_service" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name      = var.service_name
    namespace = var.namespace
    annotations = merge(
      local.annotations,
      var.annotations,
      var.service_annotations
    )
    labels = merge(
      {
        "instance"  = var.service_name
        "component" = "network"
      },
      local.labels,
      var.labels,
      var.service_labels
    )
  }

  spec {
    selector = {
      selector = "redis-${element(concat(random_string.selector.*.result, list("")), 0)}"
    }
    type = var.service_type

    port {
      port        = 6397
      target_port = var.master_port
      protocol    = "TCP"
      name        = "redis"
    }
  }
}


resource "kubernetes_service_account" "this" {

  metadata {
    name      = var.service_account_name
    namespace = var.namespace

    annotations = merge(
      local.annotations,
      var.annotations,
      var.service_account_annotations
    )

    labels = merge(
      local.labels,
      var.labels,
      var.service_account_annotations
    )
  }
}
