# Repository Settings

Define settings of this GitHub repository.

## How to use

Make sure your PAT has access to this repository. Then, follow these steps:

- set the subscription: `az account set --subscription "PROD-SelfCare"`
- run `terraform init -backend-config="backend.tfvars"`
- run `terraform plan`
- run `terraform apply`

<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_repository"></a> [repository](#module\_repository) | github.com/pagopa/selfcare-commons//infra/terraform-modules/github_repository_settings | main |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->