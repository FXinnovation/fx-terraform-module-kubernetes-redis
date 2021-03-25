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
output "config_map" {
  value     = module.this.config_map
  sensitive = true
}
output "service_account" {
  value = module.this.service_account
}
