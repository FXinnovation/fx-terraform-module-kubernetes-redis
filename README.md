# terraform-module-multi-template

Template repository for public terraform modules

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| kubernetes | >= 1.10.0 |
| random | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| kubernetes | >= 1.10.0 |
| random | >= 2.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [kubernetes_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/1.10.0/docs/resources/secret) |
| [kubernetes_service_account](https://registry.terraform.io/providers/hashicorp/kubernetes/1.10.0/docs/resources/service_account) |
| [kubernetes_service](https://registry.terraform.io/providers/hashicorp/kubernetes/1.10.0/docs/resources/service) |
| [kubernetes_stateful_set](https://registry.terraform.io/providers/hashicorp/kubernetes/1.10.0/docs/resources/stateful_set) |
| [random_string](https://registry.terraform.io/providers/hashicorp/random/2.0/docs/resources/string) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| annotations | Map of annotations that will be applied on all resources. | `map(string)` | `{}` | no |
| args | Redis command arguments.<br>Can be used to specify command line arguments, for example:<br>args = [<br> "redis-server",<br> "--maxmemory-policy volatile-ttl"<br>] | `list(string)` | `[]` | no |
| image | The docker image registry used to retrieve the redis image | `string` | `"redis"` | no |
| image\_version | n/a | `string` | `"6.2.1"` | no |
| kubernetes\_node\_selector | n/a | `map(string)` | `{}` | no |
| labels | Map of labels that will be applied on all resources. | `map(string)` | `{}` | no |
| liveness\_probe | Redis  Liveness Probe configuration | `map(string)` | <pre>{<br>  "enabled": true,<br>  "failure_threshold": 5,<br>  "initial_delay_seconds": 30,<br>  "period_seconds": 10,<br>  "success_threshold": 1,<br>  "timeout_seconds": 5<br>}</pre> | no |
| namespace | Name of the namespace in which to deploy the module. | `string` | `"redis"` | no |
| pod\_annotations | n/a | `map(string)` | `{}` | no |
| port | # # Redis Master parameters # | `number` | `"6379"` | no |
| readiness\_probe | Redis Readiness Probe configuration | `map(string)` | <pre>{<br>  "enabled": true,<br>  "failure_threshold": 5,<br>  "initial_delay_seconds": 30,<br>  "period_seconds": 10,<br>  "success_threshold": 1,<br>  "timeout_seconds": 5<br>}</pre> | no |
| secrets | secrets to use for Redis | `map(string)` | `{}` | no |
| security\_context | n/a | `map(string)` | <pre>{<br>  "enabled": true,<br>  "fs_group": 1001,<br>  "run_as_user": 1001<br>}</pre> | no |
| service\_account\_annotations | Map of service account annotations that will be applied on all resources. | `map(string)` | `{}` | no |
| service\_account\_name | Service\_account\_name for Redis | `string` | `"redis"` | no |
| service\_annotations | n/a | `map(string)` | `{}` | no |
| service\_type | n/a | `string` | `"ClusterIP"` | no |
| stateful\_set\_annotations | Map of annotations that will be applied on the statefulset. | `map(string)` | `{}` | no |
| stateful\_set\_automount\_service\_account\_token | Whether or not to mount the service account token in the pods. | `bool` | `true` | no |
| stateful\_set\_labels | Map of labels that will be applied on the statefulset. | `map(string)` | `{}` | no |
| stateful\_set\_name | Name of the statefulset to deploy. | `string` | `"redis"` | no |
| stateful\_set\_template\_annotations | Map of annotations that will be applied on the statefulset template. | `map(string)` | `{}` | no |
| stateful\_set\_template\_labels | Map of labels that will be applied on the statefulset template. | `map(string)` | `{}` | no |
| stateful\_set\_volume\_claim\_template\_annotations | Map of annotations that will be applied on the statefulset volume claim template. | `map(string)` | `{}` | no |
| stateful\_set\_volume\_claim\_template\_enabled | Whether or not to enable the volume claim template on the statefulset. | `bool` | `true` | no |
| stateful\_set\_volume\_claim\_template\_labels | Map of labels that will be applied on the statefulset volume claim template. | `map(string)` | `{}` | no |
| stateful\_set\_volume\_claim\_template\_name | Name of the statefulset's volume claim template. | `map(string)` | `{}` | no |
| stateful\_set\_volume\_claim\_template\_requests\_storage | Size of storage the stateful set volume claim template requests. | `string` | `"200Gi"` | no |
| stateful\_set\_volume\_claim\_template\_storage\_class | Storage class to use for the stateful set volume claim template. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| secret | n/a |
| service | n/a |
| service\_account | n/a |
| statefulset | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Versioning
This repository follows [Semantic Versioning 2.0.0](https://semver.org/)

## Git Hooks
This repository uses [pre-commit](https://pre-commit.com/) hooks.
