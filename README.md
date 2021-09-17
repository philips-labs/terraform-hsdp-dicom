<img src="https://cdn.rawgit.com/hashicorp/terraform-website/master/content/source/assets/images/logo-hashicorp.svg" width="500px">

# HSDP DICOM Store
The HSDP DICOM Store service provides cloud-based storage for Digital Imaging and Communications in Medicine (DICOM) Data as part of the HSDP Store. It enables standards-based interoperability between enabled apps and devices with third-party systems via DICOMweb standard interfaces.

To read more, [Click Here](https://www.hsdp.io/documentation/dicom-store)

## Overiew
This project helps to configuration of HSDP DICOM Store and HSDP DICOM Gateway. Client can reference or use this project. Client can also use the terraform resources directly and automate as per the need.

DICOM Store Dedicated Instance Use Case

<img src="/images/dedicated.png" alt="Dedicated Setup Use Case Example"/>

DICOM Store Shared Instance Use Case

<img src="/images/shared.png" alt="Dedicated Setup Use Case Example"/>

## Scope
* Responsible for creating role/groups/service accounts etc in HSDP IAM as per DICOM Store Requirements.
* Responsible for creating S3Creds policies.
* Responsible for posting the configuration into DICOM Store.

## Out of Scope
* Creating IAM Organizations.
* Creating LCM policies as described in the DICOM Store documentation.


## Requirements

| Name | Version |
|------|---------|
|[hsdp](https://registry.terraform.io/modules/philips-labs/dicom/hsdp/latest) | >= 0.19.7 |
|[Terraform](https://www.terraform.io/downloads.html) | >= v0.15.1|

## Providers
| Name | Version |
|------|---------|
|[hsdp](https://registry.terraform.io/modules/philips-labs/dicom/hsdp/latest) | >= 0.19.7 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [hsdp_dicom_object_store](https://registry.terraform.io/providers/philips-software/hsdp/0.18.8/docs/resources/dicom_object_store) |
| [hsdp_dicom_repository](https://registry.terraform.io/providers/philips-software/hsdp/0.18.8/docs/resources/dicom_repository) |
| [hsdp_dicom_store_config](https://registry.terraform.io/providers/philips-software/hsdp/0.18.8/docs/resources/dicom_store_config) |
| [hsdp_iam_application](https://registry.terraform.io/providers/philips-software/hsdp/0.18.8/docs/resources/iam_application) |
| [hsdp_iam_group](https://registry.terraform.io/providers/philips-software/hsdp/0.18.8/docs/resources/iam_group) |
| [hsdp_iam_proposition](https://registry.terraform.io/providers/philips-software/hsdp/0.18.8/docs/resources/iam_proposition) |
| [hsdp_iam_role](https://registry.terraform.io/providers/philips-software/hsdp/0.18.8/docs/resources/iam_role) |
| [hsdp_iam_service](https://registry.terraform.io/providers/philips-software/hsdp/0.18.8/docs/resources/iam_service) |
| [hsdp_iam_user](https://registry.terraform.io/providers/philips-software/hsdp/0.18.8/docs/data-sources/iam_user) |
| [hsdp_s3creds_policy](https://registry.terraform.io/providers/philips-software/hsdp/0.18.8/docs/resources/s3creds_policy) |

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
| managing\_root\_definition | Managing root configuration | <pre>object({<br>  organization_id                       = string<br>  admin_users                           = list(string)<br>  dicom_users                           = optional(list(string))<br>  s3creds_bucket_name                   = string<br>  s3creds_product_key                   = string<br>  force_delete_object_store             = optional(bool)<br>  use_default_object_store_for_all_orgs = optional(bool)<br>  repository_organization_id            = optional(string)<br>  shared_cdr_service_account_id         = optional(string)<br>  mpi_endpoint                          = optional(string)<br>})</pre> | `null` | no |
| tenant\_definitions | List of tenant configurations | <pre>list(object({<br>  tenant_organization_id        = string<br>  admin_users                   = list(string)<br>  dicom_users                   = optional(list(string))<br>  s3creds_bucket_name           = optional(string)<br>  s3creds_product_key           = optional(string)<br>  force_delete_object_store     = optional(bool)<br>  repository_organization_id    = optional(string)<br>  purge_cdr_data                = optional(bool)<br>}))</pre> | `[]` | no |


## Outputs

No outputs
# Contact / Getting help

Post your questions on the `#terraform` HSDP Slack channel

# License

License is MIT
