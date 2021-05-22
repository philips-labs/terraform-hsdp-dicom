resource "hsdp_s3creds_policy" "policy" {
  count = var.s3creds_product_key != null ? 1 : 0

  product_key = var.s3creds_product_key

  policy = <<POLICY
{
  "conditions": {
    "managingOrganizations": [ "${var.organization_id}" ],
    "groups": [ "${hsdp_iam_group.grp_dicom_s3creds[count.index].name}" ]
  },
  "allowed": {
    "resources": [ "${var.organization_id}/*" ],
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
