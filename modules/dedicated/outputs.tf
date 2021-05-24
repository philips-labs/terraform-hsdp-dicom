output "svc_dicom_cdr_service_id" {
  description = "Dedicated DICOM CDR Service account ID"
  value       = hsdp_iam_service.svc_dicom_cdr.service_id
}