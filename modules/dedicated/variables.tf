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

variable "use_default_object_store_for_all_orgs" {
  description = "Use the same object store for all the sub orgs/tenanents"
  type        = bool
  default     = false
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