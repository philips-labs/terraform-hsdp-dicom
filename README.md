<img src="https://cdn.rawgit.com/hashicorp/terraform-website/master/content/source/assets/images/logo-hashicorp.svg" width="500px">

# HSDP DICOM Store module

## Requirements

| Name | Version |
|------|---------|
| hsdp | >= 0.12.8 |

## Providers

| Name | Version |
|------|---------|
| hsdp | >= 0.12.2 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [hsdp_dicom_object_store](https://registry.terraform.io/providers/philips-software/hsdp/0.12.2/docs/resources/dicom_object_store) |
| [hsdp_dicom_repository](https://registry.terraform.io/providers/philips-software/hsdp/0.12.2/docs/resources/dicom_repository) |
| [hsdp_dicom_store_config](https://registry.terraform.io/providers/philips-software/hsdp/0.12.2/docs/resources/dicom_store_config) |
| [hsdp_iam_group](https://registry.terraform.io/providers/philips-software/hsdp/0.12.2/docs/resources/iam_group) |
| [hsdp_iam_role](https://registry.terraform.io/providers/philips-software/hsdp/0.12.2/docs/resources/iam_role) |
| [hsdp_s3creds_policy](https://registry.terraform.io/providers/philips-software/hsdp/0.12.2/docs/resources/s3creds_policy) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cdr\_base\_url | The base URL of the CDR instance to use for DICOM Store | `string` | n/a | yes |
| dss\_config\_url | The DICOM Store config URL -- Provided by HSDP | `string` | n/a | yes |
| iam\_org\_id | The IAM organization you will be onboarding to DICOM Store | `string` | n/a | yes |
| s3creds\_credentials | S3Credentials to use for DICOM Store | <pre>list(object({<br>    endpoint    = string<br>    product_key = string<br>    bucket_name = string<br>    folder_path = string<br>    service_id  = string<br>    private_key = string<br>  }))</pre> | `[]` | no |
| service\_ids | Service IDs that should have write access to the DICOM Store | `list(string)` | `[]` | no |
| static\_credentials | Static credentials to use for DICOM Store | <pre>list(object({<br>    endpoint    = string<br>    bucket_name = string<br>    access_key  = string<br>    secret_key  = string<br>  }))</pre> | `[]` | no |
| user\_ids | User IDs that should have write access to the DICOM Store | `list(string)` | `[]` | no |

## Outputs

No output.

## Terraform Installation
Download terraform from https://www.terraform.io/downloads.html and follow the instructions.

## Running Terraform Scripts
* `terraform init`
* `terraform plan`
* `terraform apply`

# Contact / Getting help

Post your questions on the `#terraform` HSDP Slack channel

# License

License is MIT
