output "managing_root_organization_id" {
  value       = hsdp_cdr_org.root_onboard.org_id
  description = "Shared - Managing root organization id"
}

output "managing_s3creds_service_id" {
  value       = hsdp_iam_service.svc_dicom_s3creds.service_id
  description = "Shared - Managing root s3creds service id"
}

output "managing_s3creds_service_private_key" {
  value       = replace(hsdp_iam_service.svc_dicom_s3creds.private_key, "\n", "")
  description = "Shared - Managing root s3creds private key"
}

output "managing_s3creds_group_name" {
  value       = hsdp_iam_group.grp_dicom_s3creds.name
  description = "Shared - Managing s3creds group name"
}
