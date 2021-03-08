#####
# Global
#####
variable "namespace" {
  description = "Name of the namespace in which to deploy the module."
  default     = "redis"
  type        = string
}

variable "annotations" {
  description = "Map of annotations that will be applied on all resources."
  default     = {}
  type        = map(string)
}

variable "service_account_annotations" {
  description = "Map of service account annotations that will be applied on all resources."
  default     = {}
  type        = map(string)
}

variable "labels" {
  description = "Map of labels that will be applied on all resources."
  default     = {}
  type        = map(string)
}

#####
# StatefulSet
#####

variable "stateful_set_name" {
  description = "Name of the statefulset to deploy."
  default     = "redis"
  type        = string
}

variable "stateful_set_annotations" {
  description = "Map of annotations that will be applied on the statefulset."
  default     = {}
  type        = map(string)
}

variable "stateful_set_automount_service_account_token" {
  description = "Whether or not to mount the service account token in the pods."
  default     = true
  type        = bool
}

variable "stateful_set_labels" {
  description = "Map of labels that will be applied on the statefulset."
  default     = {}
  type        = map(string)
}

variable "stateful_set_template_annotations" {
  description = "Map of annotations that will be applied on the statefulset template."
  default     = {}
  type        = map(string)
}

variable "stateful_set_template_labels" {
  description = "Map of labels that will be applied on the statefulset template."
  default     = {}
  type        = map(string)
}

variable "stateful_set_volume_claim_template_enabled" {
  description = "Whether or not to enable the volume claim template on the statefulset."
  default     = true
  type        = bool
}

variable "stateful_set_volume_claim_template_annotations" {
  description = "Map of annotations that will be applied on the statefulset volume claim template."
  default     = {}
  type        = map(string)
}

variable "stateful_set_volume_claim_template_labels" {
  description = "Map of labels that will be applied on the statefulset volume claim template."
  default     = {}
  type        = map(string)
}

variable "stateful_set_volume_claim_template_name" {
  description = "Name of the statefulset's volume claim template."
  default     = {}
  type        = map(string)
}

variable "stateful_set_volume_claim_template_storage_class" {
  description = "Storage class to use for the stateful set volume claim template."
  default     = null
  type        = string
}

variable "stateful_set_volume_claim_template_requests_storage" {
  description = "Size of storage the stateful set volume claim template requests."
  default     = "200Gi"
  type        = string
}


variable "image" {
  description = "The docker image registry used to retrieve the redis image"
  default     = "redis"
  type        = string
}

variable "image_version" {
  default = "6.2.1"
  type    = string
}

##
## Kubernetes settings
##

variable "kubernetes_node_selector" {
  type    = map(string)
  default = {}

}

##
## Redis Master parameters
##
variable "port" {
  default = "6379"
  type    = number
}

variable "args" {
  type = list(string)

  description = <<EOF
Redis command arguments.
Can be used to specify command line arguments, for example:
args = [
 "redis-server",
 "--maxmemory-policy volatile-ttl"
]
EOF

  default = []
}



variable "liveness_probe" {
  type        = map(string)
  description = "Redis  Liveness Probe configuration"

  default = {
    enabled               = true
    initial_delay_seconds = 30
    period_seconds        = 10
    timeout_seconds       = 5
    success_threshold     = 1
    failure_threshold     = 5
  }
}

variable "readiness_probe" {
  type        = map(string)
  description = "Redis Readiness Probe configuration"

  default = {
    enabled               = true
    initial_delay_seconds = 30
    period_seconds        = 10
    timeout_seconds       = 5
    success_threshold     = 1
    failure_threshold     = 5
  }
}

variable "pod_annotations" {
  type    = map(string)
  default = {}
}

variable "security_context" {
  default = {
    enabled     = true
    fs_group    = 1001
    run_as_user = 1001
  }
  type = map(string)
}

variable "service_type" {
  default = "ClusterIP"
  type    = string
}

variable "service_annotations" {
  type    = map(string)
  default = {}
}

variable "secrets" {
  description = "secrets to use for Redis"
  type        = map(string)
  default     = {}
}

variable "service_account_name" {
  description = "Service_account_name for Redis"
  type        = string
  default     = "redis"
}
