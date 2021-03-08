#####
# Statefulset
#####

output "statefulset" {
  value     = module.this.statefulset
  sensitive = true
}

#####
# Service
#####

output "service" {
  value     = module.this.service
  sensitive = true
}

output "secret" {
  value     = module.this.secret
  sensitive = true
}

output "service_account" {
  value     = module.this.service_account
  sensitive = true
}
