#####
# Global
#####



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
