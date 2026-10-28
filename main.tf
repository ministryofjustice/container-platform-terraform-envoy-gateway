locals {
  namespace = "envoy-gateway-system"
}

resource "kubernetes_namespace_v1" "envoy_gateway_system" {
  metadata {
    name = local.namespace

    annotations = {
      "container-platform.justice.gov.uk/can-use-loadbalancer-services" = "true"
    }

    labels = {
      "pod-security.kubernetes.io/enforce" = "privileged"
    }
  }
}

resource "helm_release" "envoy_gateway" {
  depends_on = [kubernetes_namespace_v1.envoy_gateway_system]

  name             = "${var.name}-envoy-gateway"
  repository       = "oci://docker.io/envoyproxy"
  chart            = "gateway-helm"
  namespace        = local.namespace
  create_namespace = false
  version          = "1.8.6"

  values = [
    yamlencode({
      deployment = {
        replicas = var.envoy_controller_replicas
      }
      # temporary override to resolve the emudhra certificate issue, remove in future versions if resolved
      global = {
        images = {
          envoyProxy = {
            image = "docker.io/envoyproxy/envoy:distroless-v1.38.9"
          }
        }
      }
    })
  ]

  wait    = true
  timeout = 300
}
