resource "hsdp_s3creds_policy" "policy" {
  count = var.iam_org_id != "" ? 1 : 0
  product_key = var.s3creds_product_key
  policy      = <<POLICY
{
  "conditions": {
    "managingOrganizations": [ "${var.iam_org_id}" ],
    "groups": [ "${hsdp_iam_group.grp_dicm_s3creds.name}" ]
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
