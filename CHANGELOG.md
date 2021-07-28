# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).
## v0.1.4
- Fixed https://github.com/philips-software/terraform-provider-hsdp/issues/96

## v0.1.3
- Fixed missing permissions and dependency for s3creds policy creation.
- Fixed https://github.com/philips-labs/terraform-hsdp-dicom/issues/4
- Upgraded HSDP Provider Version

## v0.1.2
- Fixed CDR offboarding. Added missing permissions.
- Fixed https://github.com/philips-labs/terraform-hsdp-dicom/issues/3

## v0.0.12
- Split user and admin lists
- Allow login based user lists

## v0.0.11
- Add explicit repository_organization_id to module input

## v0.0.7
- Add generated service to group

## v0.0.6
- Update provider to auto-generate global_reference_id fields

## v0.0.5
- Improvements from DICOM team

## v0.0.4
- Fix dependency, should be on config

## v0.0.3
- Ensure IAM DICOM Group is in place before onboarding

## v0.0.2
- Add user_ids argument

## v0.0.1
- Initial commit
