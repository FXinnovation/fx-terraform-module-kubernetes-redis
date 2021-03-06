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
  default     = "redis"
  type        = string
}

variable "stateful_set_volume_claim_template_storage_class" {
  description = "Storage class to use for the stateful set volume claim template."
  default     = null
  type        = string
}

variable "stateful_set_volume_claim_template_requests_storage" {
  description = "Size of storage the stateful set volume claim template requests."
  default     = "10Gi"
  type        = string
}


variable "image" {
  description = "The docker image registry used to retrieve the redis image"
  default     = "redis"
  type        = string
}

variable "image_version" {
  description = "image version to use for redis"
  default     = "6.2.1"
  type        = string
}

##
## Kubernetes settings
##

variable "kubernetes_node_selector" {
  description = "kubernetes node selecrtor"
  type        = map(string)
  default     = {}

}

##
## Redis Master parameters
##
variable "service_port" {
  description = "port valuue for the redis"
  default     = "6379"
  type        = string
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
  description = <<EOF
  "Redis  Liveness Probe configuration"
    example : {
      enabled               = true
      initial_delay_seconds = 30
      period_seconds        = 10
    }
  EOF
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

variable "security_context" {
  description = "security context if required "
  default = {
    enabled     = true
    fs_group    = 1001
    run_as_user = 1001
  }
  type = map(string)
}

variable "service_type" {
  description = "service type of"
  default     = "ClusterIP"
  type        = string
}

variable "service_annotations" {
  description = "service annotations required for redis"
  type        = map(string)
  default     = {}
}

variable "configuration" {
  description = <<EOF
  "configration needed for redis "
    ref: http://download.redis.io/redis-stable/redis.conf
  EOF
  type        = string
  default     = ""
}

variable "service_account_name" {
  description = "Service_account_name for Redis"
  type        = string
  default     = "redis"
}

variable "config_map_name" {
  description = "config_map name for Redis"
  type        = string
  default     = "redis"

}

variable "config_map_annotations" {
  description = "Map of config annotations that will be applied on all resources."
  default     = {}
  type        = map(string)

}

variable "config_map_labels" {
  description = "Map of config_map lables that will be applied on all resources."
  default     = {}
  type        = map(string)

}

variable "service_name" {
  description = "service name for Redis"
  type        = string
  default     = "redis"

}

variable "service_labels" {
  description = "Map of service lables that will be applied on all resources."
  default     = {}
  type        = map(string)

}

variable "replicas" {
  description = "replicas required for the redis instance"
  default     = "1"
  type        = string
}

variable "resources_limits_cpu" {
  description = <<EOF
  "Amount of cpu time that the application limits."

    Redis Master resource limits
    ref: http://kubernetes.io/docs/user-guide/compute-resources/
      master_resource_limits = {
        cpu = "100m"
      }
EOF
  default     = "100m"
  type        = string
}

variable "resources_limits_memory" {
  description = <<EOF
    Redis Master resource limits
    ref: http://kubernetes.io/docs/user-guide/compute-resources/
      master_resource_limits = {
        memory = "256Mi"
      }
    EOF
  default     = "256Mi"
  type        = string
}

variable "resources_requests_cpu" {
  description = <<EOF
  "Amount of cpu time that the application limits."

    Redis Master resource limits
    ref: http://kubernetes.io/docs/user-guide/compute-resources/
      master_resource_limits = {
        cpu = "100m"
      }
  EOF
  default     = "100m"
  type        = string
}

variable "resources_requests_memory" {
  description = <<EOF
    Redis Master resource limits
    ref: http://kubernetes.io/docs/user-guide/compute-resources/
      master_resource_limits = {
        memory = "256Mi"
      }
    EOF

  default = "256Mi"
  type    = string
}

variable "redis_image_pull_policy" {
  description = "One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise."
  default     = "IfNotPresent"
  type        = string
}
