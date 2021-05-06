data "hsdp_config" "iam" {
  service = "iam"
}

data "hsdp_iam_user" "user" {
  count    = length(var.dicom_users)
  username = var.dicom_users[count.index]
}

data "hsdp_iam_user" "admin" {
  count    = length(var.admin_users)
  username = var.admin_users[count.index]
}