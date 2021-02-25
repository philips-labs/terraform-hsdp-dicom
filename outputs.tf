output "dicom_cdr_service_id" {
  description = "Service ID of the generated CDR service account"
  value       = hsdp_iam_service.dicom_cdr_service.service_id
}

output "dicom_cdr_service_private_key" {
  description = "Private key of the generated CDR service account"
  value       = hsdp_iam_service.dicom_cdr_service.private_key
  sensitive   = true
}
