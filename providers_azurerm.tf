provider azurerm {
  features {}
}

provider "docker" {
  host    = "npipe:////.//pipe//docker_engine"
}

provider "local" {
  # Configuration options
}


terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.39.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.13.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.2.3"
    }
  }
}



