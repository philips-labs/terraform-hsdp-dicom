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
    # The following role does not currently exist in IAM
    #"ROLE.DELETE",
    "GROUP.READ",
    "GROUP.WRITE",
    # The following role does not currently exist in IAM
    #"GROUP.DELETE"
  ]
  managing_organization = var.managing_root_definition.organization_id
}

resource "hsdp_iam_group" "grp_org_admin" {
  name                  = "GRP_ORG_ADMIN_TF"
  description           = "GRP_ORG_ADMIN_TF - Terraform managed"
  roles                 = [hsdp_iam_role.role_org_admin.id]
  users                 = data.hsdp_iam_user.admin.*.id
  managing_organization = var.managing_root_definition.organization_id
}

resource "hsdp_iam_role" "role_dicom_admin" {
  name        = "ROLE_DICOM_ADMIN_TF"
  description = "ROLE_DICOM_ADMIN_TF - Terraform managed"

  permissions = [
    "CP-CONFIG.SERVICEADMIN",
    "CP-CONFIG.ALL"
  ]
  managing_organization = var.managing_root_definition.organization_id
}

resource "hsdp_iam_group" "grp_dicom_admin" {
  name                  = "GRP_DICOM_ADMIN_TF"
  description           = "GRP_DICOM_ADMIN_TF - Terraform managed"
  roles                 = [hsdp_iam_role.role_dicom_admin.id]
  users                 = data.hsdp_iam_user.admin.*.id
  managing_organization = var.managing_root_definition.organization_id
}

