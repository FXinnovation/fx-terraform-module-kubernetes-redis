#####
# Providers
#####

provider "random" {
}

provider "kubernetes" {

  load_config_file = true
}
