terraform {
  required_version = ">= 0.15.1"
  experiments      = [module_variable_optional_attrs]

  required_providers {
    hsdp = {
      source  = "philips-software/hsdp"
      version = ">= 0.18.8"
    }
  }
}
