locals {
  prefix = var.random_prefix ? "${random_id.id.hex}_" : ""
}

resource "random_id" "id" {
  byte_length = 8
}

resource "hsdp_iam_proposition" "prop_dicom" {
  name            = "PROP_DICOM_TF"
  description     = "PROP_DICOM_TF - Terraform managed"
  organization_id = var.organization_id
}

resource "hsdp_iam_application" "app_dicom" {
  name           = "APP_DICOM_TF"
  description    = "APP_DICOM_TF - Terraform managed"
  proposition_id = hsdp_iam_proposition.prop_dicom.id
}

resource "hsdp_iam_role" "role_dicom_cdr" {
  name        = "ROLE_DICOM_CDR_TF"
  description = "ROLE_DICOM_CDR_TF - Terraform managed"

  lifecycle {
    ignore_changes = [description]
  }

  permissions = [
    "ALL.READ",
    "ALL.WRITE"
  ]
  managing_organization = var.organization_id
}

resource "hsdp_iam_group" "grp_dicom_cdr" {
  name                  = "${local.prefix}GRP_DICOM_CDR_TF"
  description           = "GRP_DICOM_CDR_TF - Terraform managed"
  roles                 = [hsdp_iam_role.role_dicom_cdr.id]
  services              = [hsdp_iam_service.svc_dicom_cdr.id]
  managing_organization = var.organization_id
}

# This should only be created for dedicated isntances
resource "hsdp_iam_service" "svc_dicom_cdr" {
  name           = "${local.prefix}SVC_DICOM_CDR_TF"
  description    = "SVC_DICOM_CDR_TF - Terraform managed"
  application_id = hsdp_iam_application.app_dicom.id
  validity       = 36
  scopes         = ["openid"]
  default_scopes = ["openid"]
}

resource "hsdp_dicom_store_config" "svc_cdr" {
  config_url      = var.dss_config_url
  organization_id = var.organization_id

  cdr_service_account {
    service_id  = hsdp_iam_service.svc_dicom_cdr.service_id
    private_key = replace(hsdp_iam_service.svc_dicom_cdr.private_key, "\n", "")
  }

  /*
  dynamic "fhir_store" {
    for_each = var.mpi_endpoint
    content {
      mpi_endpoint = fhir_store.value
    }
  }
  */
}

resource "hsdp_iam_role" "role_dicom_s3creds" {
  name        = "ROLE_DICOM_S3CREDS_TF"
  description = "ROLE_DICOM_S3CREDS_TF - Terraform managed"

  permissions = [
    "S3CREDS_POLICY.ALL",
    "S3CREDS_ACCESS.GET"
  ]
  managing_organization = var.organization_id
}

resource "hsdp_iam_service" "svc_dicom_s3creds" {
  name           = "${local.prefix}SVC_DICOM_S3CREDS_TF"
  description    = "SVC_DICOM_S3CREDS_TF - Terraform managed"
  application_id = hsdp_iam_application.app_dicom.id
  validity       = 36
  scopes         = ["openid"]
  default_scopes = ["openid"]
}

resource "hsdp_iam_group" "grp_dicom_s3creds" {
  name                  = "${local.prefix}GRP_DICOM_S3CREDS_TF"
  description           = "GRP_DICOM_S3CREDS_TF - Terraform managed"
  roles                 = [hsdp_iam_role.role_dicom_s3creds.id]
  users                 = data.hsdp_iam_user.admin.*.id
  services              = [hsdp_iam_service.svc_dicom_s3creds.id]
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
    folder_path = "${var.organization_id}/"
    service_account {
      service_id            = hsdp_iam_service.svc_dicom_s3creds.service_id
      private_key           = replace(hsdp_iam_service.svc_dicom_s3creds.private_key, "\n", "")
      access_token_endpoint = "${data.hsdp_config.iam.url}/oauth2/access_token"
      token_endpoint        = "${data.hsdp_config.iam.url}/authorize/oauth2/token"
    }
  }
}

# Few clients uses Default Object Store for all the orgs. Hence it should only created based on need.
resource "hsdp_dicom_repository" "dicom_repository" {
  count                      = !(var.use_default_object_store_for_all_orgs == null || var.use_default_object_store_for_all_orgs == false) ? 0 : (var.s3creds_product_key != null ? 1 : 0)
  config_url                 = var.dss_config_url
  repository_organization_id = var.repository_organization_id
  organization_id            = var.organization_id
  object_store_id            = hsdp_dicom_object_store.object_store[count.index].id
}

resource "hsdp_iam_role" "role_org_admin" {
  name        = "ROLE_ORG_ADMIN_TF"
  description = "ROLE_ORG_ADMIN_TF - Terraform managed"

  permissions = [
    "APPLICATION.READ",
    "APPLICATION.WRITE",
    # The following role does not currently exist in IAM
    #"APPLICATION.DELETE",
    "CLIENT.READ",
    "CLIENT.WRITE",
    "PERMISSION.READ",
    "PROPOSITION.READ",
    "PROPOSITION.WRITE",
    "SCOPE.WRITE",
    "USER.READ",
    "USER.WRITE",
    "SERVICE.DELETE",
    # The following role does not currently exist in IAM
    #"ROLE.DELETE",
    "GROUP.READ",
    "GROUP.WRITE",
    # Below permissions are needed for CDR onboarding and offboarding
    "ORGANIZATION.READ",
    "ORGANIZATION.WRITE",
    "ORGANIZATION.PURGE",
    "PATIENT.PURGE"
  ]
  managing_organization = var.organization_id
}

resource "hsdp_iam_group" "grp_org_admin" {
  name                  = "${local.prefix}GRP_ORG_ADMIN_TF"
  description           = "GRP_ORG_ADMIN_TF - Terraform managed"
  roles                 = [hsdp_iam_role.role_org_admin.id]
  users                 = data.hsdp_iam_user.admin.*.id
  managing_organization = var.organization_id
}

resource "hsdp_iam_role" "role_dicom_admin" {
  name        = "ROLE_DICOM_ADMIN_TF"
  description = "ROLE_DICOM_ADMIN_TF - Terraform managed"

  lifecycle {
    ignore_changes = [description]
  }

  permissions = [
    "CP-CONFIG.SERVICEADMIN",
    "CP-CONFIG.ALL"
  ]
  managing_organization = var.organization_id
}

resource "hsdp_iam_group" "grp_dicom_admin" {
  name                  = "${local.prefix}GRP_DICOM_ADMIN_TF"
  description           = "GRP_DICOM_ADMIN_TF - Terraform managed"
  roles                 = [hsdp_iam_role.role_dicom_admin.id, hsdp_iam_role.role_dicom_user.id]
  users                 = data.hsdp_iam_user.admin.*.id
  managing_organization = var.organization_id
}

resource "hsdp_iam_role" "role_dicom_user" {
  name        = "ROLE_DICOM_USERS_TF"
  description = "ROLE_DICOM_USERS_TF - Terraform managed"

  permissions = [
    "CP-DICOM.ALL",
    "CP-DICOM.READ",
    "CP-DICOM.WRITE",
    "CP-DICOM.SEARCH",
    "CP-MANAGE.DELETE",
    "CP-CONFIG.READ",
    "CP-DICOM.IMPORT",
    "CP-DICOM.UPLOAD",
    "CP-DICOM.MERGE",
    "ALL.READ",
    "ALL.WRITE",
    "S3CREDS_POLICY.ALL"
  ]
  managing_organization = var.organization_id
}

resource "hsdp_iam_group" "grp_dicom_users" {
  name                  = "${local.prefix}GRP_DICOM_USERS_TF"
  description           = "GRP_DICOM_USERS_TF - Terraform managed"
  roles                 = [hsdp_iam_role.role_dicom_user.id]
  users                 = data.hsdp_iam_user.user.*.id
  managing_organization = var.organization_id
}
