resource "hsdp_iam_role" "dicom_cdr" {
  name        = "ROLE_DICOM_CDR_TF"
  description = "ROLE_DICOM_CDR_TF - Terraform managed"

  permissions = [
    "ALL.READ",
    "ALL.WRITE"
  ]
  managing_organization = var.iam_org_id
}


resource "hsdp_iam_role" "dicom_admin" {
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
  users                 = concat(var.user_ids, [])
  services              = concat(var.service_ids, [hsdp_iam_service.dicom_cdr_service.id])
  managing_organization = var.iam_org_id
}


resource "hsdp_iam_group" "dicom_admin" {
  name                  = "GRP_DICOM_ADMIN_TF"
  description           = "GRP_DICOM_ADMIN_TF - Terraform managed"
  roles                 = [hsdp_iam_role.dicom_admin.id]
  users                 = concat(var.user_ids, [])
  services              = concat(var.service_ids, [])
  managing_organization = var.iam_org_id
}

resource "hsdp_iam_service" "dicom_cdr_service" {
  name           = "SVC_DICOM_CDR_TF"
  description    = "SVC_DICOM_CDR_TF - Terraform managed"
  application_id = hsdp_iam_application.dicom_app.id
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
