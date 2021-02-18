variable "iam_org_id" {
  description = "The IAM organization you will be onboarding to DICOM Store"
  type        = string
}

variable "dicom_store_config_url" {
  description = "The DICOM Store config URL -- Provided by HSDP"
  type        = string
}

variable "cdr_base_url" {
  description = "The base URL of the CDR instance to use for DICOM Store"
  type        = string
}

variable "user_ids" {
  description = "User IDs that should have write access to the DICOM Store"
  type = list(string)
  default = []
}
variable "service_ids" {
  description = "Service IDs that should have write access to the DICOM Store"
  type = list(string)
  default = []
}

variable "s3creds_credentials" {
  description = "S3Credentials to use for DICOM Store"
  type = list(object({
    endpoint    = string
    product_key = string
    bucket_name = string
    folder_path = string
    service_id  = string
    private_key = string
  }))
  sensitive = true
  default = []
}

variable "static_credentials" {
  description = "Static credentials to use for DICOM Store"
  type = list(object({
    endpoint    = string
    bucket_name = string
    access_key  = string
    secret_key  = string
  }))
  sensitive = true
  default   = []
}
