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

variable "user_logins" {
  description = "User login IDs that should have write access to the DICOM Store"
  type        = list(string)
  default     = []
}

variable "admin_ids" {
  description = "Admin user IDs for DICOM Store"
  type = list(string)
  default = []
}

variable "admin_logins" {
  description = "Admin login IDS for DICOM Store"
  type = list(string)
  default = []
}

variable "service_ids" {
  description = "Service IDs that should have write access to the DICOM Store"
  type        = list(string)
  default     = []
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

variable "repository_organization_id" {
  description = "DICOM Data Repository organization id"
  type        = string
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

variable "s3creds_bucket_name" {
  description = "S3Creds Bucket Name"
  type        = string
}

variable "s3creds_product_key" {
  description = "S3Creds Product Key"
  type        = string
}

variable "iam_url" {
  description = "IAM Url"
  type        = string
}

variable "is_instance_shared" {
  description = "Is DICOM instance shared?"
  type        = bool
}

variable "svc_dicom_cdr_id" {
  description = "Is DICOM instance shared?"
  type        = string
  default     = ""
}

variable "mpi_endpoint" {
  description = "MPI Endpoint (E.g: https://foo.com)"
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
  description = "Region E.g us-east, eu-west"
  type        = string
}
