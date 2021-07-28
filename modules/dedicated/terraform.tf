terraform {
  required_version = ">= 0.15.1"

  required_providers {
    hsdp = {
      source  = "philips-software/hsdp"
      version = ">= 0.18.5"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}
