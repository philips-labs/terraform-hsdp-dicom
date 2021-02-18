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

variable "s3creds_credentials" {
  description = "S3Creds to IAM organization mapping for DICOM Store"
  type = object({
    endpoint    = string
    product_key = string
    bucket_name = string
    folder_path = string
    service_id  = string
    private_key = string
  })
  sensitive = true
}
