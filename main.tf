#####
# Locals
#####

locals {
  labels = {
    part-of    = "monitoring"
    managed-by = "terraform"
  }
  annotations = {}
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
  metadata {
    name      = var.stateful_set_name
    namespace = var.namespace
    annotations = merge(
      local.annotations,
      var.annotations,
      var.stateful_set_annotations
    )
    labels = merge(
      local.labels,
      {
        instance  = var.stateful_set_name
        component = "cache"
      },
      var.labels,
      var.stateful_set_labels
    )
  }
  spec {
    replicas     = var.replicas
    service_name = kubernetes_service.this.metadata.0.name
    update_strategy {
      type = "RollingUpdate"
    }
    selector {
      match_labels = {
        selector = "redis-${random_string.selector.result}"
      }
    }
    template {
      metadata {
        annotations = merge(
          local.annotations,
          { "configuration/hash" = sha256(join(", ", values(var.secrets))) },
          var.annotations,
          var.stateful_set_template_annotations
        )
        labels = merge(
          local.labels,
          {
            instance  = var.stateful_set_name
            component = "cache"
            cache     = "enabled"
            selector  = "redis-${random_string.selector.result}"
          },
          var.labels,
          var.stateful_set_template_labels
        )
      }
      spec {
        security_context {
          fs_group    = var.security_context["fs_group"]
          run_as_user = var.security_context["run_as_user"]
        }
        node_selector                   = var.kubernetes_node_selector
        automount_service_account_token = var.stateful_set_automount_service_account_token
        service_account_name            = kubernetes_service_account.this.metadata.0.name
        container {
          name              = "redis"
          image             = "${var.image}:${var.image_version}"
          image_pull_policy = var.redis_image_pull_policy
          args              = var.args
          command           = ["redis-server", "/usr/local/etc/redis/redis.conf"]
          resources {
            limits {
              cpu    = var.resources_limits_cpu
              memory = var.resources_limits_memory
            }
            requests {
              cpu    = var.resources_requests_cpu
              memory = var.resources_requests_memory
            }
          }
          port {
            container_port = "6379"
            protocol       = "TCP"
            name           = "resp"
          }
          liveness_probe {
            initial_delay_seconds = var.liveness_probe["initial_delay_seconds"]
            period_seconds        = var.liveness_probe["period_seconds"]
            timeout_seconds       = var.liveness_probe["timeout_seconds"]
            success_threshold     = var.liveness_probe["success_threshold"]
            failure_threshold     = var.liveness_probe["failure_threshold"]
            exec {
              command = [
                "redis-cli",
                "ping",
              ]
            }
          }
          readiness_probe {
            initial_delay_seconds = var.readiness_probe["initial_delay_seconds"]
            period_seconds        = var.readiness_probe["period_seconds"]
            timeout_seconds       = var.readiness_probe["timeout_seconds"]
            success_threshold     = var.readiness_probe["success_threshold"]
            failure_threshold     = var.readiness_probe["failure_threshold"]
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
              mount_path = "/etc/redis"
              sub_path   = ""
            }
          }
          volume_mount {
            name       = "secret"
            mount_path = "/usr/local/etc/redis/redis.conf"
          }
        }
        volume {
          name = "secret"
          secret {
            secret_name = kubernetes_secret.this.metadata.0.name
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
            local.labels,
            {
              instance  = var.stateful_set_volume_claim_template_name
              component = "storage"
            },
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
      local.labels,
      {
        "instance" = var.secret_name
        component  = "configuration"
      },
      var.labels,
      var.secret_labels
    )
  }
  data = var.secrets
  type = "Opaque"
}

#####
# Service
#####

resource "kubernetes_service" "this" {
  metadata {
    name      = var.service_name
    namespace = var.namespace
    annotations = merge(
      local.annotations,
      var.annotations,
      var.service_annotations
    )
    labels = merge(
      local.labels,
      {
        "instance"  = var.service_name
        "component" = "network"
      },
      var.labels,
      var.service_labels
    )
  }

  spec {
    selector = {
      selector = "redis-${random_string.selector.result}"
    }
    type = var.service_type
    port {
      port        = var.port
      target_port = "resp"
      protocol    = "TCP"
      name        = "resp"
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
