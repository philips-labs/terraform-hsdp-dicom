resource "hsdp_s3creds_policy" "policy" {
  count = var.s3creds_product_key != null ? 1 : 0

  product_key = var.s3creds_product_key

  depends_on = [hsdp_iam_group.grp_dicom_admins]

  policy = <<POLICY
{
  "conditions": {
    "managingOrganizations": [ "${var.tenant_organization_id}" ],
    "groups": [ "${hsdp_iam_group.grp_dicom_s3creds.name}" ]
  },
  "allowed": {
    "resources": [ "${var.tenant_organization_id}/*" ],
    "actions": [
      "ALL_BUCKET",
      "GET",
      "PUT",
      "LIST",
      "DELETE"
    ]
  }
}
POLICY
}
