resource "hsdp_iam_proposition" "prop_dicom" {
  name            = "PROP_DICOM_TF"
  description     = "PROP_DICOM_TF - Terraform managed"
  organization_id = var.iam_org_id
}

resource "hsdp_iam_application" "app_diom" {
  name           = "APP_DICOM_TF"
  description    = "APP_DICOM_TF - Terraform managed"
  proposition_id = hsdp_iam_proposition.prop_dicom.id
}

resource "hsdp_iam_role" "role_org_admin" {
  name        = "ROLE_ORG_ADMIN_TF"
  description = "ROLE_ORG_ADMIN_TF - Terraform managed"

  permissions = [
    "APPLICATION.READ",
    "APPLICATION.WRITE",
    "APPLICATION.DELETE",
    "CLIENT.READ",
    "CLIENT.WRITE",
    "PERMISSION.READ",
    "PROPOSITION.READ",
    "PROPOSITION.WRITE",
    "SCOPE.WRITE",
    "USER.READ",
    "USER.WRITE",
    "SERVICE.DELETE",
    "ROLE.DELETE",
    "GROUP.READ",
    "GROUP.WRITE",
    "GROUP.DELETE"
  ]
  managing_organization = var.iam_org_id
}

resource "hsdp_iam_group" "grp_org_admin" {
  name                  = "GRP_ORG_ADMIN_TF"
  description           = "GRP_ORG_ADMIN_TF - Terraform managed"
  roles                 = [hsdp_iam_role.role_org_admin.id]
  users                 = concat(var.admin_ids, data.hsdp_iam_user.admin.*.id)
  managing_organization = var.iam_org_id
}

resource "hsdp_iam_role" "role_dicom_cdr" {
  name        = "ROLE_DICOM_CDR_TF"
  description = "ROLE_DICOM_CDR_TF - Terraform managed"

  permissions = [
    "ALL.READ",
    "ALL.WRITE"
  ]
  managing_organization = var.iam_org_id
}

resource "hsdp_iam_service" "svc_dicom_cdr" {
  name           = "SVC_DICOM_CDR_TF"
  description    = "SVC_DICOM_CDR_TF - Terraform managed"
  application_id = hsdp_iam_application.app_diom.id
  validity       = 36
  scopes         = ["openid"]
  default_scopes = ["openid"]
}

resource "hsdp_iam_group" "grp_dicom_cdr" {
  name                  = "GRP_DICOM_CDR_TF"
  description           = "GRP_DICOM_CDR_TF - Terraform managed"
  roles                 = [hsdp_iam_role.role_dicom_cdr.id]
  services              = [hsdp_iam_service.svc_dicom_cdr.id]
  managing_organization = var.iam_org_id
}


resource "hsdp_iam_role" "role_dicom_admin" {
  name        = "ROLE_DICOM_ADMIN_TF"
  description = "ROLE_DICOM_ADMIN_TF - Terraform managed"

  permissions = [
    "CP-CONFIG.SERVICEADMIN",
    "CP-CONFIG.ALL"
  ]
  managing_organization = var.iam_org_id
}

resource "hsdp_iam_group" "dicom_cdr" {
  name                  = "GRP_DICOM_CDR_TF"
  description           = "GRP_DICOM_CDR_TF - Terraform managed"
  roles                 = [hsdp_iam_role.dicom_cdr.id]
  users                 = concat(var.user_ids, data.hsdp_iam_user.user.*.id)
  services              = concat(var.service_ids, [hsdp_iam_service.dicom_cdr_service.id])
  managing_organization = var.iam_org_id
}

resource "hsdp_iam_role" "role_dicom_users" {
  name        = "ROLE_DICOM_USERS_TF"
  description = "ROLE_DICOM_USERS_TF - Terraform managed"

<<<<<<< HEAD
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
  ]
=======
resource "hsdp_iam_group" "dicom_admin" {
  name                  = "GRP_DICOM_ADMIN_TF"
  description           = "GRP_DICOM_ADMIN_TF - Terraform managed"
  roles                 = [hsdp_iam_role.dicom_admin.id]
  users                 = concat(var.admin_ids, data.hsdp_iam_user.admin.*.id)
  services              = concat(var.service_ids, [])
>>>>>>> origin/main
  managing_organization = var.iam_org_id
}

resource "hsdp_iam_group" "grp_dicom_users" {
  name                  = "GRP_DICOM_USERS_TF"
  description           = "GRP_DICOM_USERS_TF - Terraform managed"
  roles                 = [hsdp_iam_role.role_dicom_users.id]
  users                 = concat(var.user_ids, data.hsdp_iam_user.user.*.id)
  managing_organization = var.iam_org_id
}

resource "hsdp_iam_service" "svc_dicom_s3creds" {
  name           = "SVC_DICOM_S3CREDS_TF"
  description    = "SVC_DICOM_S3CREDS_TF - Terraform managed"
  application_id = hsdp_iam_application.app_diom.id
  validity       = 36
  scopes         = ["openid"]
  default_scopes = ["openid"]
}

resource "hsdp_iam_proposition" "dicom_prop" {
  name            = "PROP_DICOM_TF"
  description     = "PROP_DICOM_TF - Terraform managed"
  organization_id = var.iam_org_id
}

resource "hsdp_iam_application" "dicom_app" {
  name           = "APP_DICOM_TF"
  description    = "APP_DICOM_TF - Terraform managed"
  proposition_id = hsdp_iam_proposition.dicom_prop.id
}
