variable "iam_org_id" {
  description = "IAM organization (GUID) you have provided for DICOM Store onboarding"
  type        = string
  validation {
    condition     = can(regex("^[{]?[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$", var.iam_org_id))
    error_message = "The iam_org_id value must be a valid GUID."
  }
}

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

variable "user_ids" {
  description = "User IDs that should have write access to the DICOM Store"
  type        = list(string)
  default     = []
}

variable "service_ids" {
  description = "Service IDs that should have write access to the DICOM Store"
  type        = list(string)
  default     = []
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
  default   = []
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
