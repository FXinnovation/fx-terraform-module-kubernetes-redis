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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| annotations | Map of annotations that will be applied on all resources. | `map` | `{}` | no |
| kubernetes\_node\_selector | n/a | `map` | `{}` | no |
| labels | Map of labels that will be applied on all resources. | `map` | `{}` | no |
| master\_args | Redis command arguments.<br>Can be used to specify command line arguments, for example:<br>master\_args = [<br> "redis-server",<br> "--maxmemory-policy volatile-ttl"<br>] | `list` | `[]` | no |
| master\_disable\_commands | Comma-separated list of Redis commands to disable<br>Can be used to disable Redis commands for security reasons.<br>ref: https://github.com/bitnami/bitnami-docker-redis#disabling-redis-commands | `list(string)` | <pre>[<br>  "FLUSHDB",<br>  "FLUSHALL"<br>]</pre> | no |
| master\_extra\_flags | Redis additional command line flags<br> Can be used to specify command line flags, for example:<br> redisExtraFlags = [<br>  "--maxmemory-policy volatile-ttl",<br>  "--repl-backlog-size 1024mb"<br> ] | `list` | `[]` | no |
| master\_liveness\_probe | Redis Master Liveness Probe configuration | `map(string)` | <pre>{<br>  "enabled": true,<br>  "failure_threshold": 5,<br>  "initial_delay_seconds": 30,<br>  "period_seconds": 10,<br>  "success_threshold": 1,<br>  "timeout_seconds": 5<br>}</pre> | no |
| master\_pod\_annotations | n/a | `map(string)` | `{}` | no |
| master\_pod\_labels | Redis Master additional pod labels<br>ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ | `map(string)` | `{}` | no |
| master\_port | # # Redis Master parameters # | `string` | `"6379"` | no |
| master\_readiness\_probe | Redis Master Readiness Probe configuration | `map(string)` | <pre>{<br>  "enabled": true,<br>  "failure_threshold": 5,<br>  "initial_delay_seconds": 30,<br>  "period_seconds": 10,<br>  "success_threshold": 1,<br>  "timeout_seconds": 5<br>}</pre> | no |
| master\_resource\_limits | Redis Master resource limits<br>ref: http://kubernetes.io/docs/user-guide/compute-resources/<br>  master\_resource\_limits = {<br>    memory = "256Mi"<br>    cpu = "100m"<br>  } | `map(string)` | `{}` | no |
| master\_resource\_requests | Redis Master resource requests<br>ref: http://kubernetes.io/docs/user-guide/compute-resources/<br>  master\_resource\_requests = {<br>    memory = "256Mi"<br>    cpu = "100m"<br>  } | `map(string)` | `{}` | no |
| master\_security\_context | n/a | `map` | <pre>{<br>  "enabled": true,<br>  "fs_group": 1001,<br>  "run_as_user": 1001<br>}</pre> | no |
| master\_service\_annotations | n/a | `map(string)` | `{}` | no |
| master\_service\_type | n/a | `string` | `"ClusterIP"` | no |
| namespace | Name of the namespace in which to deploy the module. | `string` | `"default"` | no |
| redis\_image\_pull\_policy | One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. | `string` | `"IfNotPresent"` | no |
| redis\_image\_registry | The docker image registry used to retrieve the redis image | `string` | `""` | no |
| redis\_image\_repository | n/a | `string` | `""` | no |
| redis\_image\_tag | n/a | `string` | `""` | no |
| stateful\_set\_annotations | Map of annotations that will be applied on the statefulset. | `map` | `{}` | no |
| stateful\_set\_automount\_service\_account\_token | Whether or not to mount the service account token in the pods. | `bool` | `true` | no |
| stateful\_set\_labels | Map of labels that will be applied on the statefulset. | `map` | `{}` | no |
| stateful\_set\_name | Name of the statefulset to deploy. | `string` | `"redis"` | no |
| stateful\_set\_template\_annotations | Map of annotations that will be applied on the statefulset template. | `map` | `{}` | no |
| stateful\_set\_template\_labels | Map of labels that will be applied on the statefulset template. | `map` | `{}` | no |
| stateful\_set\_volume\_claim\_template\_annotations | Map of annotations that will be applied on the statefulset volume claim template. | `map` | `{}` | no |
| stateful\_set\_volume\_claim\_template\_enabled | Whether or not to enable the volume claim template on the statefulset. | `bool` | `true` | no |
| stateful\_set\_volume\_claim\_template\_labels | Map of labels that will be applied on the statefulset volume claim template. | `map` | `{}` | no |
| stateful\_set\_volume\_claim\_template\_name | Name of the statefulset's volume claim template. | `string` | `"redis"` | no |
| stateful\_set\_volume\_claim\_template\_requests\_storage | Size of storage the stateful set volume claim template requests. | `string` | `"200Gi"` | no |
| stateful\_set\_volume\_claim\_template\_storage\_class | Storage class to use for the stateful set volume claim template. | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| config\_map | n/a |
| namespace\_name | n/a |
| secret | n/a |
| service | n/a |
| service\_account | n/a |
| statefulset | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Versioning
This repository follows [Semantic Versioning 2.0.0](https://semver.org/)

## Git Hooks
This repository uses [pre-commit](https://pre-commit.com/) hooks.
