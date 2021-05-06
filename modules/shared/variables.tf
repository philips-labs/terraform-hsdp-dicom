variable "user_ids" {
  description = "List of users"
  type        = list(string)
  default     = []
}

variable "organization_id" {
  description = "The managing organization id"
  type        = string
}

variable "s3creds_bucket_name" {
  description = "The S3Cred bucket name"
  type        = string
  default     = ""
}

variable "s3creds_product_key" {
  description = "The S3Cred product key"
  type        = string
  default     = null
}

variable "dss_config_url" {
  description = "DICOM Store config URL"
  type        = string
}

variable "region" {
  description = "The HSDP Region to deploy to"
  type        = string
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

variable "shared_cdr_service_account_id" {
  description = "CDR Service Account ID which is shared by HSDP Support team after onboarding to Shared instance"
  type        = string
  validation {
    condition     = can(regex("^[{]?[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$", var.shared_cdr_service_account_id))
    error_message = "The shared_cdr_service_account_id value must be a valid GUID."
  }
}