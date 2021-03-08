#####
# Global
#####



#####
# Statefulset
#####

output "statefulset" {
  value     = kubernetes_stateful_set.this
  sensitive = true
}

#####
# Service
#####

output "service" {
  value     = kubernetes_service.this
  sensitive = true
}

output "secret" {
  value     = kubernetes_secret.this
  sensitive = true
}

output "service_account" {
  value     = kubernetes_service_account.this
  sensitive = true
}
