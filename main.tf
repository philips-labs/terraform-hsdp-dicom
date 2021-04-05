resource "hsdp_dicom_store_config" "config" {

  config_url      = var.dss_config_url
  organization_id = var.iam_org_id

  depends_on = [hsdp_iam_group.grp_dicom_admin]
}

resource "hsdp_dicom_store_config" "svc_cdr" {
  count = var.is_instance_shared ? 0 : 1

  config_url      = var.dss_config_url
  organization_id = var.iam_org_id

  cdr_service_account {
    service_id  = hsdp_iam_service.svc_dicom_cdr.service_id
    private_key = hsdp_iam_service.svc_dicom_cdr.private_key
  }


  dynamic "fhir_store" {
    for_each = var.mpi_endpoints
    content {
      mpi_endpoint = fhir_store.value
    }
  }
}

resource "hsdp_dicom_object_store" "s3creds_store" {
  count           = var.iam_org_id != "" ? 1 : 0
  config_url      = hsdp_dicom_store_config.config.config_url
  organization_id = var.iam_org_id
  description     = "S3Creds Object Store - Terraform managed"

  s3creds_access {
    endpoint    = lookup(var.s3creds_bucket_endpoint, var.region)
    product_key = var.s3creds_product_key
    bucket_name = var.s3creds_bucket_name
    folder_path = "/${var.iam_org_id}/"
    service_account {
      service_id  = hsdp_iam_service.svc_dicom_s3creds.service_id
      private_key = hsdp_iam_service.svc_dicom_s3creds.private_key
      # Todo: replace
      access_token_endpoint = "${var.iam_url}/oauth2/access_token"
      token_endpoint        = "${var.iam_url}/oauth2/access_token"
      # Todo: Make name as option field
      name = "Terraform Managed"
    }
  }
}

resource "hsdp_dicom_repository" "s3creds_repository" {
  count                      = var.iam_org_id != "" ? 1 : 0
  config_url                 = hsdp_dicom_store_config.config.config_url
  repository_organization_id = var.repository_organization_id
  organization_id            = var.iam_org_id
  object_store_id            = hsdp_dicom_object_store.s3creds_store[count.index].id
}

resource "hsdp_dicom_object_store" "static_store" {
  count           = length(var.static_credentials)
  config_url      = hsdp_dicom_store_config.config.config_url
  organization_id = var.iam_org_id
  description     = "Static Object Store - Terraform managed"

  static_access {
    endpoint    = lookup(var.s3creds_bucket_endpoint, var.region)
    bucket_name = var.static_credentials[count.index].bucket_name
    access_key  = var.static_credentials[count.index].access_key
    secret_key  = var.static_credentials[count.index].secret_key
  }
}

resource "hsdp_dicom_repository" "static_repository" {
  count                      = length(var.static_credentials)
  config_url                 = hsdp_dicom_store_config.config.config_url
  organization_id            = var.iam_org_id
  repository_organization_id = var.static_credentials[count.index].repository_organization_id
  object_store_id            = hsdp_dicom_object_store.static_store[count.index].id
}
