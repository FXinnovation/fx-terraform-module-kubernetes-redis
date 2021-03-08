#####
# Providers
#####

provider "random" {
  version = "~> 3.0.0"
}

provider "kubernetes" {
  version          = "1.10.0"
  load_config_file = true
}
