terraform {
  required_version = ">= 0.13"

  required_providers {

    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "1.10.0"
    }
  }
}
