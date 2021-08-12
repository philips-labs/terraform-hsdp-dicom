module "dedicated" {
  count  = var.is_instance_shared ? 0 : (var.managing_root_definition != null ? 1 : 0) # Dedicated DICOM
  source = "./modules/dedicated"

  region                                = var.region
  dss_config_url                        = var.dss_config_url
  cdr_base_url                          = var.cdr_base_url
  admin_users                           = var.managing_root_definition.admin_users != null ? var.managing_root_definition.admin_users : []
  dicom_users                           = var.managing_root_definition.dicom_users != null ? var.managing_root_definition.dicom_users : []
  organization_id                       = var.managing_root_definition.organization_id
  s3creds_bucket_name                   = var.managing_root_definition.s3creds_bucket_name
  s3creds_product_key                   = var.managing_root_definition.s3creds_product_key
  force_delete_object_store             = var.managing_root_definition.force_delete_object_store
  use_default_object_store_for_all_orgs = var.managing_root_definition.use_default_object_store_for_all_orgs
  repository_organization_id            = var.managing_root_definition.repository_organization_id
  random_prefix                         = var.random_prefix
  mpi_endpoint                          = var.managing_root_definition.mpi_endpoint
  purge_cdr_data                        = var.managing_root_definition.purge_cdr_data
  allow_data_store                      = var.managing_root_definition.allow_data_store
}

module "shared" {
  count  = var.is_instance_shared && var.managing_root_definition != null ? 1 : 0 # Shared DICOM
  source = "./modules/shared"

  region                        = var.region
  dss_config_url                = var.dss_config_url
  cdr_base_url                  = var.cdr_base_url
  admin_users                   = var.managing_root_definition.admin_users != null ? var.managing_root_definition.admin_users : []
  dicom_users                   = var.managing_root_definition.dicom_users != null ? var.managing_root_definition.dicom_users : []
  organization_id               = var.managing_root_definition.organization_id
  repository_organization_id    = var.managing_root_definition.repository_organization_id
  s3creds_bucket_name           = var.managing_root_definition.s3creds_bucket_name
  s3creds_product_key           = var.managing_root_definition.s3creds_product_key
  force_delete_object_store     = var.managing_root_definition.force_delete_object_store
  shared_cdr_service_account_id = var.managing_root_definition.shared_cdr_service_account_id
  purge_cdr_data                = var.managing_root_definition.purge_cdr_data
  allow_data_store              = var.managing_root_definition.allow_data_store
}

module "tenant_dedicated" {
  count = !var.is_instance_shared ? length(var.tenant_definitions) : 0

  source = "./modules/tenant"


  region                        = var.region
  dss_config_url                = var.dss_config_url
  cdr_base_url                  = var.cdr_base_url
  admin_users                   = var.tenant_definitions[count.index].admin_users != null ? var.tenant_definitions[count.index].admin_users : []
  dicom_users                   = var.tenant_definitions[count.index].dicom_users != null ? var.tenant_definitions[count.index].dicom_users : []
  managing_root_organization_id = module.dedicated[0].managing_root_organization_id
  tenant_organization_id        = var.tenant_definitions[count.index].tenant_organization_id
  s3creds_service_id            = module.dedicated[0].managing_s3creds_service_id
  s3creds_service_private_key   = module.dedicated[0].managing_s3creds_service_private_key
  s3creds_group_name            = module.dedicated[0].managing_s3creds_group_name
  s3creds_bucket_name           = var.managing_root_definition.s3creds_bucket_name
  s3creds_product_key           = var.managing_root_definition.s3creds_product_key
  force_delete_object_store     = var.tenant_definitions[count.index].force_delete_object_store
  repository_organization_id    = var.tenant_definitions[count.index].repository_organization_id
  purge_cdr_data                = var.tenant_definitions[count.index].purge_cdr_data
}

module "tenant_shared" {
  count  = var.is_instance_shared ? length(var.tenant_definitions) : 0
  source = "./modules/tenant"

  # count                         = length(var.tenant_definitions)
  region                        = var.region
  dss_config_url                = var.dss_config_url
  cdr_base_url                  = var.cdr_base_url
  admin_users                   = var.tenant_definitions[count.index].admin_users != null ? var.tenant_definitions[count.index].admin_users : []
  dicom_users                   = var.tenant_definitions[count.index].dicom_users != null ? var.tenant_definitions[count.index].dicom_users : []
  managing_root_organization_id = module.shared[0].managing_root_organization_id
  tenant_organization_id        = var.tenant_definitions[count.index].tenant_organization_id
  s3creds_service_id            = module.shared[0].managing_s3creds_service_id
  s3creds_service_private_key   = module.shared[0].managing_s3creds_service_private_key
  s3creds_group_name            = module.shared[0].managing_s3creds_group_name
  s3creds_bucket_name           = var.managing_root_definition.s3creds_bucket_name
  s3creds_product_key           = var.managing_root_definition.s3creds_product_key
  force_delete_object_store     = var.tenant_definitions[count.index].force_delete_object_store
  repository_organization_id    = var.tenant_definitions[count.index].repository_organization_id
  purge_cdr_data                = var.tenant_definitions[count.index].purge_cdr_data
}
