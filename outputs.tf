output "dicom_cdr_service_id" {
  description = "Service ID of the generated CDR service account"
  value       = join("", module.dedicated.*.svc_dicom_cdr_service_id)
}

/*
output "dicom_cdr_service_private_key" {
  description = "Private key of the generated CDR service account"
  value       = hsdp_iam_service.svc_dicom_cdr.private_key
  sensitive   = true
}

output "dicom_s3creds_service_id" {
  description = "Service ID of the generated S3Creds service account"
  value       = hsdp_iam_service.svc_dicom_s3creds.service_id
}

output "dicom_s3creds_service_private_key" {
  description = "Private key of the generated S3Creds service account"
  value       = hsdp_iam_service.svc_dicom_s3creds.private_key
  sensitive   = true
}
*/
