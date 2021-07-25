<img src="https://cdn.rawgit.com/hashicorp/terraform-website/master/content/source/assets/images/logo-hashicorp.svg" width="500px">

# HSDP DICOM Store module

## Requirements

| Name | Version |
|------|---------|
|[hsdp](https://registry.terraform.io/modules/philips-labs/dicom/hsdp/latest) | >= 0.16.1 |
|[Terraform](https://www.terraform.io/downloads.html) | >= v0.15.1|

## Providers

| Name | Version |
|------|---------|
|[hsdp](https://registry.terraform.io/modules/philips-labs/dicom/hsdp/latest) | >= 0.16.1 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [hsdp_dicom_object_store](https://registry.terraform.io/providers/philips-software/hsdp/0.16.1/docs/resources/dicom_object_store) |
| [hsdp_dicom_repository](https://registry.terraform.io/providers/philips-software/hsdp/0.16.1/docs/resources/dicom_repository) |
| [hsdp_dicom_store_config](https://registry.terraform.io/providers/philips-software/hsdp/0.16.1/docs/resources/dicom_store_config) |
| [hsdp_iam_application](https://registry.terraform.io/providers/philips-software/hsdp/0.16.1/docs/resources/iam_application) |
| [hsdp_iam_group](https://registry.terraform.io/providers/philips-software/hsdp/0.16.1/docs/resources/iam_group) |
| [hsdp_iam_proposition](https://registry.terraform.io/providers/philips-software/hsdp/0.16.1/docs/resources/iam_proposition) |
| [hsdp_iam_role](https://registry.terraform.io/providers/philips-software/hsdp/0.16.1/docs/resources/iam_role) |
| [hsdp_iam_service](https://registry.terraform.io/providers/philips-software/hsdp/0.16.1/docs/resources/iam_service) |
| [hsdp_iam_user](https://registry.terraform.io/providers/philips-software/hsdp/0.16.1/docs/data-sources/iam_user) |
| [hsdp_s3creds_policy](https://registry.terraform.io/providers/philips-software/hsdp/0.16.1/docs/resources/s3creds_policy) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Environment details. Possible values `dev`, `client-test`, `prod` | `string` |  | yes |
| region | DICOM Store deployed region. Possible values `us-east-1`, `eu-west-1` | `string` |  | yes |
| cdr\_base\_url | CDR Base URL which is provided for DICOM Store onboarding (E.g: https://cdr-example.us-east.philips-healthsuite.com) | `string` | n/a | yes |
| dss\_config\_url | DICOM Store config URL (Should have received from Onboarding Request ticket Response) | `string` | n/a | yes |
| service\_ids | Service IDs that should have write access to the DICOM Store | `list(string)` | `[]` | no |
| oauth2_client_id | IAM OAuth Client Id | `string` |  | yes |
| oauth2_password | IAM OAuth secret/password | `string` |  | yes |
| org_admin_username | IAM Organization admin username. e.g. `admin@philips.com` | `string` |  | yes |
| org_admin_password | IAM Organization admin password. | `string` |  | yes |
| managing\_root\_definition | Managing root configuration | <pre>object({<br>  organization_id                       = string<br>  admin_users                           = list(string)<br>  dicom_users                           = optional(list(string))<br>  s3creds_bucket_name                   = optional(string)<br>  s3creds_product_key                   = optional(string)<br>  force_delete_object_store             = optional(bool)<br>  use_default_object_store_for_all_orgs = optional(bool)<br>  repository_organization_id            = optional(string)<br>  shared_cdr_service_account_id         = optional(string)<br>  mpi_endpoint                          = optional(string)<br>})</pre> | `null` | no |
| tenant\_definitions | List of tenant configurations | <pre>list(object({<br>  managing_root_organization_id = string<br>  tenant_organization_id        = string<br>  admin_users                   = list(string)<br>  dicom_users                   = optional(list(string))<br>  s3creds_bucket_name           = optional(string)<br>  s3creds_product_key           = optional(string)<br>  force_delete_object_store     = optional(bool)<br>  repository_organization_id    = optional(string)<br>  purge_cdr_data                = optional(bool)<br>}))</pre> | `[]` | no |


## Outputs

No outputs
# Contact / Getting help

Post your questions on the `#terraform` HSDP Slack channel

# License

License is MIT
