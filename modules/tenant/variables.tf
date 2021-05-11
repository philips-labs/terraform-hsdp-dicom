variable "user_ids" {
  description = "List of users"
  type        = list(string)
  default     = []
}

variable "managing_root_organization_id" {
  description = "The managing organization id"
  type        = string
}

variable "tenant_organization_id" {
  description = "The tenant organization id"
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
  default     = null
}

variable "is_instance_shared" {
  description = "Is DICOM instance shared?"
  type        = bool
  default     = false
}

variable "cdr_base_url" {
  description = "CDR Base URL which is provided for DICOM Store onboarding (E.g: https://cdr-example.us-east.philips-healthsuite.com)"
  type        = string
  validation {
    condition     = can(regex("^https://", var.cdr_base_url))
    error_message = "The cdr_base_url value must be a valid url, starting with \"https://\"."
  }
}

variable "force_delete_object_store" {
  description = "This will delete the object store entry, you will not get the older data which was processed with this entry. Use this with caution."
  type        = bool
  default     = false
}
