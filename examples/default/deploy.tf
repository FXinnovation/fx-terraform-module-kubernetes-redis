
#####
# Randoms
#####

resource "random_string" "this" {
  upper   = false
  number  = false
  special = false
  length  = 8
}

#####
# Context
#####

resource "kubernetes_namespace" "this" {
  metadata {
    name = random_string.this.result
  }
}

#####
# Module
#####

module "this" {
  source    = "../.."
  namespace = kubernetes_namespace.this.metadata.0.name
  secrets   = file("${path.root}/templates/redis.conf")
}
