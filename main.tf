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
  version          = "1.8.3"

  values = [
    yamlencode({
      deployment = {
        replicas = var.envoy_controller_replicas
      }
    })
  ]

  wait    = true
  timeout = 300
}
