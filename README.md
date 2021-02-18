<img src="https://cdn.rawgit.com/hashicorp/terraform-website/master/content/source/assets/images/logo-hashicorp.svg" width="500px">

# HSDP DICOM Store module

## Requirements

| Name | Version |
|------|---------|
| hsdp | >= 0.11.2 |

## Providers

| Name | Version |
|------|---------|
| hsdp | >= 0.11.2 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [hsdp_dicom_object_store](https://registry.terraform.io/providers/philips-software/hsdp/0.11.2/docs/resources/dicom_object_store) |
| [hsdp_dicom_repositiory](https://registry.terraform.io/providers/philips-software/hsdp/0.11.2/docs/resources/dicom_repositiory) |
| [hsdp_dicom_store_config](https://registry.terraform.io/providers/philips-software/hsdp/0.11.2/docs/resources/dicom_store_config) |
| [hsdp_s3creds_policy](https://registry.terraform.io/providers/philips-software/hsdp/0.11.2/docs/resources/s3creds_policy) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cdr\_base\_url | The base URL of the CDR instance to use for DICOM Store | `string` | n/a | yes |
| dicom\_store\_config\_url | The DICOM Store config URL -- Provided by HSDP | `string` | n/a | yes |
| iam\_org\_id | The IAM organization you will be onboarding to DICOM Store | `string` | n/a | yes |
| s3creds\_credentials | S3Creds to IAM organization mapping for DICOM Store | <pre>object({<br>     endpoint = string<br>     product_key = string<br>     bucket_name = string<br>     folder_path = string<br>     service_id = string<br>     private_key = string<br>   })</pre> | `{}` | no |
| static\_credentials | Static Access to IAM organization mapping for DICOM Store | <pre>object({<br>      endpoint = string<br>      bucket_name = string<br>      access_key = string<br>      secret_key = string<br>   })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| hsdp\_s3creds\_policy\_id | The generated S3Creds Policy ID |

# Contact / Getting help

Post your questions on the `#terraform` HSDP Slack channel

# License

License is MIT
