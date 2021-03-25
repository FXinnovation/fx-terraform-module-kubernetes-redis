# Default example

## Usage

```
# terraform init
# terraform apply
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| kubernetes | 1.10.0 |
| random | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| kubernetes | 1.10.0 |
| random | >= 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| this | ../.. |  |

## Resources

| Name |
|------|
| [kubernetes_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/1.10.0/docs/resources/namespace) |
| [random_string](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| config\_map | n/a |
| service | #### Service #### |
| service\_account | n/a |
| statefulset | #### Statefulset #### |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
