# container-platform-terraform-envoy-gateway

[![Ministry of Justice Repository Compliance Badge](https://github-community.service.justice.gov.uk/repository-standards/api/container-platform-terraform-envoy-gateway/badge)](https://github-community.service.justice.gov.uk/repository-standards/container-platform-terraform-envoy-gateway)

Terraform module that installs the Envoy Gateway controller on an EKS cluster using the official Helm chart.

This module handles the **CRD and controller layer only**. Use it alongside [container-platform-terraform-gateway-api](https://github.com/ministryofjustice/container-platform-terraform-gateway-api) to create the actual Gateway API resources (GatewayClass, Gateway, EnvoyProxy, ListenerSet).

## What this module creates

- A namespace named `envoy-gateway-system`
- The Envoy Gateway Helm release

The Helm chart installs two sets of CRDs as part of the release:
- **Gateway API CRDs** — `GatewayClass`, `Gateway`, `HTTPRoute`, `GRPCRoute`, etc.
- **Envoy Gateway CRDs** — `EnvoyProxy`, `EnvoyPatchPolicy`, `BackendTrafficPolicy`, `ListenerSet`, etc.

## Usage

```hcl
module "envoy_gateway" {
  source = "github.com/ministryofjustice/container-platform-terraform-envoy-gateway?ref=<tag>"

  # Optional
  # name                      = "default"
  # envoy_controller_replicas = 2
}
```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `name` | Name used for the Helm release. | `string` | `"default"` |
| `envoy_controller_replicas` | Number of replicas for the Envoy Gateway controller deployment. | `number` | `2` |

## License

[MIT License](LICENSE)
