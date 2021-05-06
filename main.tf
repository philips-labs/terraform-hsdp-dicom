module "dedicated" {
  count  = var.is_instance_shared ? 0 : 1 # Dedicated DICOM
  source = "./modules/dedicated"

  admin_users         = var.managing_root_definition.admin_users != null ? var.managing_root_definition.admin_users : []
  dicom_users         = var.managing_root_definition.dicom_users != null ? var.managing_root_definition.dicom_users : []
  organization_id     = var.managing_root_definition.organization_id
  region              = var.region
  dss_config_url      = var.dss_config_url
  s3creds_bucket_name = var.managing_root_definition.s3creds_bucket_name
  s3creds_product_key = var.managing_root_definition.s3creds_product_key
}

/*
module "shared" {
  count  = var.is_instance_shared ? 1 : 0 # Shared DICOM
  source = "./modules/shared"

  admin_users         = var.managing_root_definition.admin_users != null ? var.managing_root_definition.admin_users : []
  dicom_users         = var.managing_root_definition.dicom_users != null ? var.managing_root_definition.dicom_users : []
  organization_id     = var.managing_root_definition.organization_id
  region              = var.region
  dss_config_url      = var.dss_config_url
  s3creds_bucket_name = var.managing_root_definition.s3creds_bucket_name
  s3creds_product_key = var.managing_root_definition.s3creds_product_key
}
*/
