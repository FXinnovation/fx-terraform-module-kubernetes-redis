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
| [kubernetes_config_map](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) |
| [kubernetes_service](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) |
| [kubernetes_service_account](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) |
| [kubernetes_stateful_set](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/stateful_set) |
| [random_string](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| annotations | Map of annotations that will be applied on all resources. | `map(string)` | `{}` | no |
| args | Redis command arguments.<br>Can be used to specify command line arguments, for example:<br>args = [<br> "redis-server",<br> "--maxmemory-policy volatile-ttl"<br>] | `list(string)` | `[]` | no |
| config\_map\_annotations | Map of config annotations that will be applied on all resources. | `map(string)` | `{}` | no |
| config\_map\_labels | Map of config\_map lables that will be applied on all resources. | `map(string)` | `{}` | no |
| config\_map\_name | config\_map name for Redis | `string` | `"redis"` | no |
| configuration | "configration needed for redis "<br>    ref: http://download.redis.io/redis-stable/redis.conf | `string` | `""` | no |
| image | The docker image registry used to retrieve the redis image | `string` | `"redis"` | no |
| image\_version | image version to use for redis | `string` | `"6.2.1"` | no |
| kubernetes\_node\_selector | kubernetes node selecrtor | `map(string)` | `{}` | no |
| labels | Map of labels that will be applied on all resources. | `map(string)` | `{}` | no |
| liveness\_probe | "Redis  Liveness Probe configuration"<br>    example : {<br>      enabled               = true<br>      initial\_delay\_seconds = 30<br>      period\_seconds        = 10<br>    } | `map(string)` | <pre>{<br>  "enabled": true,<br>  "failure_threshold": 5,<br>  "initial_delay_seconds": 30,<br>  "period_seconds": 10,<br>  "success_threshold": 1,<br>  "timeout_seconds": 5<br>}</pre> | no |
| namespace | Name of the namespace in which to deploy the module. | `string` | `"redis"` | no |
| readiness\_probe | Redis Readiness Probe configuration | `map(string)` | <pre>{<br>  "enabled": true,<br>  "failure_threshold": 5,<br>  "initial_delay_seconds": 30,<br>  "period_seconds": 10,<br>  "success_threshold": 1,<br>  "timeout_seconds": 5<br>}</pre> | no |
| redis\_image\_pull\_policy | One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. | `string` | `"IfNotPresent"` | no |
| replicas | replicas required for the redis instance | `string` | `"1"` | no |
| resources\_limits\_cpu | "Amount of cpu time that the application limits."<br><br>    Redis Master resource limits<br>    ref: http://kubernetes.io/docs/user-guide/compute-resources/<br>      master\_resource\_limits = {<br>        cpu = "100m"<br>      } | `string` | `"100m"` | no |
| resources\_limits\_memory | Redis Master resource limits<br>    ref: http://kubernetes.io/docs/user-guide/compute-resources/<br>      master\_resource\_limits = {<br>        memory = "256Mi"<br>      } | `string` | `"256Mi"` | no |
| resources\_requests\_cpu | "Amount of cpu time that the application limits."<br><br>    Redis Master resource limits<br>    ref: http://kubernetes.io/docs/user-guide/compute-resources/<br>      master\_resource\_limits = {<br>        cpu = "100m"<br>      } | `string` | `"100m"` | no |
| resources\_requests\_memory | Redis Master resource limits<br>    ref: http://kubernetes.io/docs/user-guide/compute-resources/<br>      master\_resource\_limits = {<br>        memory = "256Mi"<br>      } | `string` | `"256Mi"` | no |
| security\_context | security context if required | `map(string)` | <pre>{<br>  "enabled": true,<br>  "fs_group": 1001,<br>  "run_as_user": 1001<br>}</pre> | no |
| service\_account\_annotations | Map of service account annotations that will be applied on all resources. | `map(string)` | `{}` | no |
| service\_account\_name | Service\_account\_name for Redis | `string` | `"redis"` | no |
| service\_annotations | service annotations required for redis | `map(string)` | `{}` | no |
| service\_labels | Map of service lables that will be applied on all resources. | `map(string)` | `{}` | no |
| service\_name | service name for Redis | `string` | `"redis"` | no |
| service\_port | port valuue for the redis | `string` | `"6379"` | no |
| service\_type | service type of | `string` | `"ClusterIP"` | no |
| stateful\_set\_annotations | Map of annotations that will be applied on the statefulset. | `map(string)` | `{}` | no |
| stateful\_set\_automount\_service\_account\_token | Whether or not to mount the service account token in the pods. | `bool` | `true` | no |
| stateful\_set\_labels | Map of labels that will be applied on the statefulset. | `map(string)` | `{}` | no |
| stateful\_set\_name | Name of the statefulset to deploy. | `string` | `"redis"` | no |
| stateful\_set\_template\_annotations | Map of annotations that will be applied on the statefulset template. | `map(string)` | `{}` | no |
| stateful\_set\_template\_labels | Map of labels that will be applied on the statefulset template. | `map(string)` | `{}` | no |
| stateful\_set\_volume\_claim\_template\_annotations | Map of annotations that will be applied on the statefulset volume claim template. | `map(string)` | `{}` | no |
| stateful\_set\_volume\_claim\_template\_enabled | Whether or not to enable the volume claim template on the statefulset. | `bool` | `true` | no |
| stateful\_set\_volume\_claim\_template\_labels | Map of labels that will be applied on the statefulset volume claim template. | `map(string)` | `{}` | no |
| stateful\_set\_volume\_claim\_template\_name | Name of the statefulset's volume claim template. | `string` | `"redis"` | no |
| stateful\_set\_volume\_claim\_template\_requests\_storage | Size of storage the stateful set volume claim template requests. | `string` | `"10Gi"` | no |
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
