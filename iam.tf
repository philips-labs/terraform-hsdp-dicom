resource "hsdp_iam_role" "dicom_cdr" {
  name        = "ROLE_DICOM_CDR"
  description = "Role for ROLE_DICOM_CDR - Terraform managed"

  permissions = [
    "ALL.READ",
    "ALL.WRITE",
    "CP-DICOM.ALL"
  ]
  managing_organization = var.iam_org_id
}

resource "hsdp_iam_role" "dicom_admin" {
  name        = "ROLE_DICOM_ADMIN"
  description = "Role for ROLE_DICOM_ADMIN - Terraform managed"

  permissions = [
    "CP-CONFIG.SERVICEADMIN",
    "CP-CONFIG.ALL"
  ]
  managing_organization = var.iam_org_id
}

resource "hsdp_iam_group" "dicom_cdr" {
  name                  = "GRP_DICOM_CDR"
  description           = "Group for GRP_DICOM_CDR - Terraform managed"
  roles                 = [hsdp_iam_role.dicom_cdr.id]
  users                 = []
  services              = concat(var.service_ids, [])
  managing_organization = var.iam_org_id
}

resource "hsdp_iam_group" "dicom_admin" {
  name                  = "GRP_DICOM_ADMIN"
  description           = "Group fro GRP_DICOM_ADMIN - Terraform managed"
  roles                 = [hsdp_iam_role.dicom_admin.id]
  users                 = []
  services              = concat(var.service_ids, [])
  managing_organization = var.iam_org_id
}
