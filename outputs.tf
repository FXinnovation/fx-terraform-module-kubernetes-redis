#####
# Global
#####



#####
# Statefulset
#####
output "statefulset" {
  value = module.this.statefulset
}
#####
# Service
#####
output "service" {
  value = module.this.service
}
output "secret" {
  value     = module.this.secret
  sensitive = true
}
output "service_account" {
  value = module.this.service_account
}
