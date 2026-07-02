variable "envoy_controller_replicas" {
  description = "Number of replicas for the Envoy Gateway controller deployment"
  type        = number
  default     = 2
}

variable "name" {
  description = "Name used for the Helm release"
  type        = string
  default     = "default"
}
