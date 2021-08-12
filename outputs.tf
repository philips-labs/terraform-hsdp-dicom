output "dedicated_dicom_cdr_service_id" {
  description = "Service ID of the generated CDR service account"
  value       = join("", module.dedicated.*.svc_dicom_cdr_service_id)
}

# output "managing_s3creds_service_private_key" {
#   value       = module.shared[0].managing_s3creds_service_private_key
#   description = "Managing root s3creds service id"
# }
