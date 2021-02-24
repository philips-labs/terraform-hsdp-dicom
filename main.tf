resource "hsdp_dicom_store_config" "config" {
  config_url      = var.dss_config_url
  organization_id = var.iam_org_id

  depends_on = [hsdp_iam_group.dicom_admin]
}

resource "hsdp_dicom_object_store" "s3creds_store" {
  count           = length(var.s3creds_credentials)
  config_url      = hsdp_dicom_store_config.config.config_url
  organization_id = var.iam_org_id
  description     = "S3Creds Object Store -- Terraform managed"

  s3creds_access {
    endpoint    = var.s3creds_credentials[count.index].endpoint
    product_key = var.s3creds_credentials[count.index].product_key
    bucket_name = var.s3creds_credentials[count.index].bucket_name
    folder_path = "/${var.iam_org_id}/"
    service_account {
      service_id  = var.s3creds_credentials[count.index].service_id
      private_key = var.s3creds_credentials[count.index].private_key
      name        = "Service name"
    }
  }
}

resource "hsdp_dicom_repository" "s3creds_repository" {
  count           = length(var.s3creds_credentials)
  config_url      = hsdp_dicom_store_config.config.config_url
  organization_id = var.iam_org_id
  object_store_id = hsdp_dicom_object_store.s3creds_store[count.index].id
}

resource "hsdp_dicom_object_store" "static_store" {
  count           = length(var.static_credentials)
  config_url      = hsdp_dicom_store_config.config.config_url
  organization_id = var.iam_org_id
  description     = "Static Object Store -- Terraform managed"

  static_access {
    endpoint    = var.static_credentials[count.index].endpoint
    bucket_name = var.static_credentials[count.index].bucket_name
    access_key  = var.static_credentials[count.index].access_key
    secret_key  = var.static_credentials[count.index].secret_key
  }
}

resource "hsdp_dicom_repository" "static_repository" {
  count           = length(var.static_credentials)
  config_url      = hsdp_dicom_store_config.config.config_url
  organization_id = var.iam_org_id
  object_store_id = hsdp_dicom_object_store.static_store[count.index].id
}

resource "hsdp_s3creds_policy" "policy" {
  count       = length(var.s3creds_credentials)
  product_key = var.s3creds_credentials[count.index].product_key
  policy      = <<POLICY
{
  "conditions": {
    "managingOrganizations": [ "${var.iam_org_id}" ],
    "groups": [ "GRP_S3CREDS_DICOM_TF" ]
  },
  "allowed": {
    "resources": [ "${var.iam_org_id}/*" ],
    "actions": [
      "GET",
      "PUT",
      "LIST",
      "DELETE"
    ]
  }
}
POLICY
}
