#####
# Global
#####
variable "namespace" {
  description = "Name of the namespace in which to deploy the module."
  default     = "default"
}

variable "annotations" {
  description = "Map of annotations that will be applied on all resources."
  default     = {}
}

variable "labels" {
  description = "Map of labels that will be applied on all resources."
  default     = {}
}

#####
# StatefulSet
#####

variable "stateful_set_name" {
  description = "Name of the statefulset to deploy."
  default     = "redis"
}

variable "stateful_set_annotations" {
  description = "Map of annotations that will be applied on the statefulset."
  default     = {}
}

variable "stateful_set_automount_service_account_token" {
  description = "Whether or not to mount the service account token in the pods."
  default     = true
}

variable "stateful_set_labels" {
  description = "Map of labels that will be applied on the statefulset."
  default     = {}
}

variable "stateful_set_template_annotations" {
  description = "Map of annotations that will be applied on the statefulset template."
  default     = {}
}

variable "stateful_set_template_labels" {
  description = "Map of labels that will be applied on the statefulset template."
  default     = {}
}

variable "stateful_set_volume_claim_template_enabled" {
  description = "Whether or not to enable the volume claim template on the statefulset."
  default     = true
}

variable "stateful_set_volume_claim_template_annotations" {
  description = "Map of annotations that will be applied on the statefulset volume claim template."
  default     = {}
}

variable "stateful_set_volume_claim_template_labels" {
  description = "Map of labels that will be applied on the statefulset volume claim template."
  default     = {}
}

variable "stateful_set_volume_claim_template_name" {
  description = "Name of the statefulset's volume claim template."
  default     = "redis"
}

variable "stateful_set_volume_claim_template_storage_class" {
  description = "Storage class to use for the stateful set volume claim template."
  default     = null
}

variable "stateful_set_volume_claim_template_requests_storage" {
  description = "Size of storage the stateful set volume claim template requests."
  default     = "200Gi"
}


variable redis_image_registry {
  description = "The docker image registry used to retrieve the redis image"
  default     = ""
}

variable redis_image_repository {
  default = ""
}

variable redis_image_tag {
  default = ""
}

variable redis_image_pull_policy {
  description = "One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise."
  default     = "IfNotPresent"
}


##
## Kubernetes settings
##

variable kubernetes_node_selector {
  type    = map
  default = {}
}

##
## Redis Master parameters
##
variable master_port {
  default = "6379"
}

variable master_args {
  type = list

  description = <<EOF
Redis command arguments.
Can be used to specify command line arguments, for example:
master_args = [
 "redis-server",
 "--maxmemory-policy volatile-ttl"
]
EOF

  default = []
}

variable master_extra_flags {
  type = list

  description = <<EOF
 Redis additional command line flags
 Can be used to specify command line flags, for example:
 redisExtraFlags = [
  "--maxmemory-policy volatile-ttl",
  "--repl-backlog-size 1024mb"
 ]
EOF

  default = []
}

variable master_disable_commands {
  type = list(string)

  description = <<EOF
Comma-separated list of Redis commands to disable
Can be used to disable Redis commands for security reasons.
ref: https://github.com/bitnami/bitnami-docker-redis#disabling-redis-commands
EOF

  default = [
    "FLUSHDB",
    "FLUSHALL",
  ]
}

variable master_pod_labels {
  type = map(string)

  description = <<EOF
Redis Master additional pod labels
ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
EOF

  default = {}
}

variable master_resource_requests {
  type = map(string)

  description = <<EOF
Redis Master resource requests
ref: http://kubernetes.io/docs/user-guide/compute-resources/
  master_resource_requests = {
    memory = "256Mi"
    cpu = "100m"
  }
EOF

  default = {}
}

variable master_resource_limits {
  type = map(string)

  description = <<EOF
Redis Master resource limits
ref: http://kubernetes.io/docs/user-guide/compute-resources/
  master_resource_limits = {
    memory = "256Mi"
    cpu = "100m"
  }
EOF

  default = {}
}

variable master_liveness_probe {
  type        = map(string)
  description = "Redis Master Liveness Probe configuration"

  default = {
    enabled               = true
    initial_delay_seconds = 30
    period_seconds        = 10
    timeout_seconds       = 5
    success_threshold     = 1
    failure_threshold     = 5
  }
}

variable master_readiness_probe {
  type        = map(string)
  description = "Redis Master Readiness Probe configuration"

  default = {
    enabled               = true
    initial_delay_seconds = 30
    period_seconds        = 10
    timeout_seconds       = 5
    success_threshold     = 1
    failure_threshold     = 5
  }
}

variable master_pod_annotations {
  type    = map(string)
  default = {}
}

variable master_security_context {
  default = {
    enabled     = true
    fs_group    = 1001
    run_as_user = 1001
  }
}

variable master_service_type {
  default = "ClusterIP"
}

variable master_service_annotations {
  type    = map(string)
  default = {}
}
