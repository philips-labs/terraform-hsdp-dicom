resource "hsdp_dicom_store_config" "config" {

  config_url = var.dss_config_url
  organization_id = var.managing_root_definition.organization_id

  depends_on = [
    hsdp_iam_group.grp_dicom_admin
  ]
}

module "dedicated" {
  count = var.is_instance_shared ? 0 : 1 # Dedicated DICOM
  source = "modules/dedicated"

  admin_users = var.managing_root_definition.admin_logins
  dicom_users = var.managing_root_definition.user_logins
  organization_id = var.managing_root_definition.organization_id
  region = var.region
  config_url = var.dss_config_url
  s3creds_bucket_name = var.managing_root_definition.s3creds_bucket_name
  s3creds_product_key = var.managing_root_definition.s3creds_product_key
}

/*
module "shared" {
  count = var.is_instance_shared ? 1 : 0 # Shared DICOM
  source = "modules/shared"

  user_ids = data.hsdp_iam_user.user.*.id
  organization_id = var.managing_root_definition.organization_id
}
*/