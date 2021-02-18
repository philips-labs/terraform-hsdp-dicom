resource "hsdp_dicom_store_config" "config" {
  config_url      = var.dicom_store_config_url
  organization_id = var.iam_org_id
}

resource "hsdp_dicom_object_store" "store" {
  config_url      = hsdp_dicom_store_config.config.config_url
  organization_id = var.iam_org_id
  description     = "Object Store -- Terraform managed"

  dynamic "s3creds_access" {
    for_each = [var.s3creds_credentials]
    content {
      endpoint    = s3creds_access.value.endpoint
      product_key = s3creds_access.value.product_key
      bucket_name = s3creds_access.value.bucket_name
      folder_path = "/${var.iam_org_id}"
      service_account {
        service_id  = s3creds_access.value.service_id
        private_key = s3creds_access.value.private_key
        name = "Service name"
      }
    }
  }
}

resource "hsdp_dicom_repository" "repository" {
  config_url      = hsdp_dicom_store_config.config.config_url
  organization_id = var.iam_org_id
  object_store_id = hsdp_dicom_object_store.store.id
}

resource "hsdp_s3creds_policy" "policy" {
  product_key = var.s3creds_credentials.product_key
  policy      = <<POLICY
{
  "conditions": {
    "managingOrganizations": [ "${var.iam_org_id}" ],
    "groups": [ "S3CREDS_DICOM" ]
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