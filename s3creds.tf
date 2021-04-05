resource "hsdp_s3creds_policy" "policy" {
  count       = length(var.s3creds_credentials)
  product_key = var.s3creds_credentials[count.index].product_key
  # TODO: Check if policy should use var.s3creds_credentials values
  policy      = <<POLICY
{
  "conditions": {
    "managingOrganizations": [ "${var.iam_org_id}" ],
    "groups": [ "${hsdp_iam_group.grp_dicom_s3creds.name}" ]
  },
  "allowed": {
    "resources": [ "/${var.iam_org_id}/*" ],
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
