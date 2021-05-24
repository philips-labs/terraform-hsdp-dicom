variable "region" {
  description = "The HSDP Region to deploy to"
  type        = string
}

variable "organization_id" {
  description = "The managing organization id"
  type        = string
  validation {
    condition     = can(regex("^[{]?[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$", var.organization_id))
    error_message = "The organization_id value must be a valid GUID."
  }
}

variable "repository_organization_id" {
  description = "The data organization id"
  type        = string
  default     = null
}

variable "s3creds_bucket_name" {
  description = "The S3Cred bucket name"
  type        = string
  default     = null
}

variable "s3creds_product_key" {
  description = "The S3Cred product key"
  type        = string
  default     = null
}

variable "force_delete_object_store" {
  description = "This will delete the object store entry, you will not get the older data which was processed with this entry. Use this with caution."
  type        = bool
  default     = false
}

variable "dss_config_url" {
  description = "DICOM Store config URL"
  type        = string
}

variable "use_default_object_store_for_all_orgs" {
  description = "Use the same object store for all the sub orgs/tenanents"
  type        = bool
  default     = false
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

variable "admin_users" {
  description = "Admin users"
  type        = list(string)
  default     = []
}

variable "dicom_users" {
  description = "DICOM users"
  type        = list(string)
  default     = []
}

variable "random_prefix" {
  description = "Prefix names with a random prefix"
  type        = bool
  default     = false
}

variable "mpi_endpoint" {
  description = "MPI Endpoint"
  default     = ""
}
