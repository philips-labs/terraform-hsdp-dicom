resource "hsdp_iam_proposition" "prop_dicom" {
  name            = "PROP_DICOM_TF"
  description     = "PROP_DICOM_TF - Terraform managed - Shared"
  organization_id = var.organization_id
}

resource "hsdp_iam_application" "app_diom" {
  name           = "APP_DICOM_TF"
  description    = "APP_DICOM_TF - Terraform managed"
  proposition_id = hsdp_iam_proposition.prop_dicom.id
}

resource "hsdp_iam_role" "role_dicom_admin" {
  count       = length(var.admin_users) > 0 ? 1 : 0
  name        = "ROLE_DICOM_ADMINS_TF"
  description = "ROLE_DICOM_ADMINS_TF - Terraform managed - shared"

  permissions = [
    "CP-CONFIG.ALL",
    "CP-DICOM.ALL",
    "CP-MANAGE.ALL",
    "CP-DICOM.READ",
    "CP-DICOM.WRITE",
    "CP-DICOM.SEARCH",
    "CP-MANAGE.DELETE",
    "CP-CONFIG.READ",
    "CP-CONFIG.WRITE",
    "CP-DICOM.IMPORT",
    "CP-DICOM.UPLOAD",
    "CP-DICOM.MERGE",
    "ALL.READ",
    "ALL.WRITE",
    # Below permissions are needed for CDR onboarding
    "ORGANIZATION.READ",
    "ORGANIZATION.WRITE"
  ]
  managing_organization = var.organization_id
}

resource "hsdp_iam_group" "grp_dicom_admins" {
  count                 = length(var.admin_users) > 0 ? 1 : 0
  name                  = "GRP_DICOM_ADMINS_TF"
  description           = "GRP_DICOM_ADMINS_TF - Terraform managed - shared"
  roles                 = [hsdp_iam_role.role_dicom_admin[count.index].id]
  users                 = data.hsdp_iam_user.admin.*.id
  managing_organization = var.organization_id
}

resource "hsdp_iam_role" "role_dicom_user" {
  count       = length(var.dicom_users) > 0 ? 1 : 0
  name        = "ROLE_DICOM_USERS_TF"
  description = "ROLE_DICOM_USERS_TF - Terraform managed - shared"

  permissions = [
    "CP-CONFIG.ALL",
    "CP-DICOM.ALL",
    "CP-DICOM.SEARCH",
    "CP-MANAGE.DELETE",
    "CP-CONFIG.READ",
    "CP-DICOM.IMPORT",
    "CP-DICOM.UPLOAD",
    "CP-DICOM.MERGE",
    "ALL.READ",
    "ALL.WRITE",
  ]
  managing_organization = var.organization_id
}

resource "hsdp_iam_group" "grp_dicom_users" {
  count                 = length(var.dicom_users) > 0 ? 1 : 0
  name                  = "GRP_DICOM_USERS_TF"
  description           = "GRP_DICOM_USERS_TF - Terraform managed - shared"
  roles                 = [hsdp_iam_role.role_dicom_user[count.index].id]
  users                 = data.hsdp_iam_user.user.*.id
  managing_organization = var.organization_id
}

# Create the CDR Group and Role and assign the service id which is received by HSDP Support team
resource "hsdp_iam_role" "role_dicom_cdr" {
  name        = "ROLE_DICOM_CDR_TF"
  description = "ROLE_DICOM_CDR_TF - Terraform managed - shared"

  permissions = [
    "ALL.READ",
    "ALL.WRITE",
    "TASK.READ",
    "TASK.WRITE"
  ]
  managing_organization = var.organization_id
}

resource "hsdp_iam_group" "grp_dicom_cdr" {
  name                  = "GRP_DICOM_CDR_TF"
  description           = "GRP_DICOM_CDR_TF - Terraform managed - shared"
  roles                 = [hsdp_iam_role.role_dicom_cdr.id]
  services              = [var.shared_cdr_service_account_id]
  managing_organization = var.organization_id
}

resource "hsdp_iam_service" "svc_dicom_s3creds" {
  count          = var.s3creds_product_key != null ? 1 : 0
  name           = "SVC_DICOM_S3CREDS_TF"
  description    = "SVC_DICOM_S3CREDS_TF - Terraform managed - shared"
  application_id = hsdp_iam_application.app_diom.id
  validity       = 36
  scopes         = ["openid"]
  default_scopes = ["openid"]
}

resource "hsdp_iam_role" "role_dicom_s3creds" {
  count       = var.s3creds_product_key != null ? 1 : 0
  name        = "ROLE_DICOM_S3CREDS_TF"
  description = "ROLE_DICOM_S3CREDS_TF - Terraform managed - shared"

  permissions = [
    "S3CREDS_POLICY.ALL",
    "S3CREDS_ACCESS.GET"
  ]
  managing_organization = var.organization_id
}

resource "hsdp_iam_group" "grp_dicom_s3creds" {
  count                 = var.s3creds_product_key != null ? 1 : 0
  name                  = "GRP_DICOM_S3CREDS_TF"
  description           = "GRP_DICOM_S3CREDS_TF - Terraform managed - shared"
  roles                 = [hsdp_iam_role.role_dicom_s3creds.*.id]
  users                 = data.hsdp_iam_user.admin.*.id
  services              = [hsdp_iam_service.svc_dicom_s3creds.*.id]
  managing_organization = var.organization_id
}

resource "hsdp_dicom_object_store" "object_store" {
  count           = var.s3creds_product_key != null ? 1 : 0
  config_url      = var.dss_config_url
  organization_id = var.organization_id
  force_delete    = var.force_delete_object_store

  s3creds_access {
    endpoint    = lookup(var.s3creds_bucket_endpoint, var.region)
    product_key = var.s3creds_product_key
    bucket_name = var.s3creds_bucket_name
    folder_path = "/${var.organization_id}/"
    service_account {
      service_id            = hsdp_iam_service.svc_dicom_s3creds[count.index].service_id
      private_key           = replace(hsdp_iam_service.svc_dicom_s3creds[count.index].private_key, "\n", "")
      access_token_endpoint = "${data.hsdp_config.iam.url}/oauth2/access_token"
      token_endpoint        = "${data.hsdp_config.iam.url}/authorize/oauth2/token"
    }
  }
}

resource "hsdp_dicom_repository" "dicom_repository" {
  count                      = var.s3creds_product_key != null ? 1 : 0
  config_url                 = var.dss_config_url
  repository_organization_id = var.repository_organization_id
  organization_id            = var.organization_id
  object_store_id            = hsdp_dicom_object_store.object_store[count.index].id
}


data "hsdp_cdr_fhir_store" "cdr_onboard" {
  base_url    = var.cdr_base_url
  fhir_org_id = var.organization_id
}

# first onbord the managing org
resource "hsdp_cdr_org" "root_onboard" {
  fhir_store   = data.hsdp_cdr_fhir_store.cdr_onboard.endpoint
  org_id       = var.organization_id
  name         = "Manaing Org - ${var.organization_id}"
  purge_delete = false

  depends_on = [hsdp_iam_group.grp_dicom_admins]
}
