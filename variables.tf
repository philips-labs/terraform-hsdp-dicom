variable "dss_config_url" {
  description = "DICOM Store config URL (Should have received from Onboarding Request)"
  type        = string
  validation {
    condition     = can(regex("^https://dss-config", var.dss_config_url))
    error_message = "The dss_config_url value must be a valid url, starting with \"https://dss-config\"."
  }
}

variable "cdr_base_url" {
  description = "CDR Base URL which is provided for DICOM Store onboarding (E.g: https://cdr-example.us-east.philips-healthsuite.com)"
  type        = string
  validation {
    condition     = can(regex("^https://", var.cdr_base_url))
    error_message = "The cdr_base_url value must be a valid url, starting with \"https://\"."
  }
}

variable "s3creds_credentials" {
  description = "S3Credentials to use for DICOM Store"
  type = list(object({
    repository_organization_id = string
    endpoint                   = string
    product_key                = string
    bucket_name                = string
    folder_path                = string
    service_id                 = string
    private_key                = string
  }))
  sensitive = true
  default   = []
}

variable "static_credentials" {
  description = "Static credentials to use for DICOM Store"
  type = list(object({
    repository_organization_id = string
    endpoint                   = string
    bucket_name                = string
    access_key                 = string
    secret_key                 = string
  }))
  sensitive = true
  default   = []
}

variable "is_instance_shared" {
  description = "Is DICOM instance shared?"
  type        = bool
  default     = false
}

variable "mpi_endpoint" {
  description = "MPI Endpoint"
  type        = string
  default     = ""
}

variable "s3creds_bucket_endpoint" {
  type = map(any)
  default = {
    "us-east" : "https://s3-external-1.amazonaws.com",
    "us-east-1" : "https://s3-external-1.amazonaws.com",
    "eu-west" : "https://s3-eu-west-1.amazonaws.com",
    "eu-west-1" : "https://s3-eu-west-1.amazonaws.com"
  }
}

variable "region" {
  description = "The HSDP region to deploy into"
  type        = string
}

variable "shared_cdr_service_account_id" {
  description = "CDR Service Account ID which is shared by HSDP Support team after onboarding to Shared instance"
  type        = string
  default     = null
}

variable "managing_root_definition" {
  description = "Managing Root Configurations"
  type = object({
    organization_id                       = string
    admin_users                           = list(string)
    dicom_users                           = optional(list(string))
    s3creds_bucket_name                   = optional(string)
    s3creds_product_key                   = optional(string)
    use_default_object_store_for_all_orgs = optional(bool)
  })
  default = null
}

variable "tenant_definitions" {
  description = "List of tenant configurations"
  type = list(object({
    managing_root_organization_id = string
    tenant_organization_id        = string
    admin_users                   = list(string)
    dicom_users                   = optional(list(string))
    s3creds_bucket_name           = optional(string)
    s3creds_product_key           = optional(string)
  }))
  default = []
}

variable "facility_definitions" {
  description = "List of facility configurations"
  type = list(object({
    tenant_org_id       = string
    facility_org_id     = string
    user_logins         = list(string)
    s3creds_bucket_name = optional(string)
    s3creds_product_key = optional(string)
  }))
  default = []
}
