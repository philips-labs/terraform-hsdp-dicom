module "dedicated" {
  count  = var.is_instance_shared ? 0 : (var.managing_root_definition != null ? 1 : 0) # Dedicated DICOM
  source = "./modules/dedicated"

  admin_users         = var.managing_root_definition.admin_users != null ? var.managing_root_definition.admin_users : []
  dicom_users         = var.managing_root_definition.dicom_users != null ? var.managing_root_definition.dicom_users : []
  organization_id     = var.managing_root_definition.organization_id
  region              = var.region
  dss_config_url      = var.dss_config_url
  s3creds_bucket_name = var.managing_root_definition.s3creds_bucket_name
  s3creds_product_key = var.managing_root_definition.s3creds_product_key
}


module "shared" {
  count  = var.is_instance_shared && var.managing_root_definition != null ? 1 : 0 # Shared DICOM
  source = "./modules/shared"

  admin_users                   = var.managing_root_definition.admin_users != null ? var.managing_root_definition.admin_users : []
  dicom_users                   = var.managing_root_definition.dicom_users != null ? var.managing_root_definition.dicom_users : []
  organization_id               = var.managing_root_definition.organization_id
  region                        = var.region
  dss_config_url                = var.dss_config_url
  s3creds_bucket_name           = var.managing_root_definition.s3creds_bucket_name
  s3creds_product_key           = var.managing_root_definition.s3creds_product_key
  shared_cdr_service_account_id = var.shared_cdr_service_account_id
}

module "tenant" {
  source = "./modules/tenant"

  count                         = length(var.tenant_definitions)
  admin_users                   = var.tenant_definitions[count.index].admin_users != null ? var.tenant_definitions[count.index].admin_users : []
  dicom_users                   = var.tenant_definitions[count.index].dicom_users != null ? var.tenant_definitions[count.index].dicom_users : []
  managing_root_organization_id = var.tenant_definitions[count.index].managing_root_organization_id
  tenant_organization_id        = var.tenant_definitions[count.index].tenant_organization_id
  region                        = var.region
  dss_config_url                = var.dss_config_url
  cdr_base_url                  = var.cdr_base_url
  s3creds_bucket_name           = var.tenant_definitions[count.index].s3creds_bucket_name
  s3creds_product_key           = var.tenant_definitions[count.index].s3creds_product_key
  shared_cdr_service_account_id = var.shared_cdr_service_account_id
}
