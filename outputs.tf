#####
# Global
#####

output "namespace_name" {
  value = var.enabled ? var.namespace : ""
}

#####
# Statefulset
#####

output "statefulset" {
  value = kubernetes_stateful_set.this
}

#####
# Service
#####

output "service" {
  value = kubernetes_service.this
}

output "secret" {
  value     = kubernetes_secret.this
  sensitive = true
}

output "service_account" {
  value = kubernetes_service_account.this
}

output "config_map" {
  value = kubernetes_config_map.this
}
