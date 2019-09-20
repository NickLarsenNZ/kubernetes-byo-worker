variable "worker_count" {
  default = 3
}

variable "worker_prefix" {
  description = "Worker hostname prefix (before numbering)"
  default     = "worker"
}

variable "worker_index_start" {
  description = "Worker hostname starting index"
  default     = 0
}

variable "worker_index_zero_pad" {
  description = "Worker hostname index padding"
  default     = 2
}

variable "worker_suffix" {
  description = "Worker hostname suffix (after numbering)"
  default     = ""
}

variable "worker_domain_name" {
  description = "Domain name of the workers"
  default     = "local"
}

variable "apiserver_fqdn" {
  description = "Full DNS name for accessing the Kubernetes API from outside the cluster"
  default     = "kubernetes.local"
}

variable "apiserver_port" {
  description = "kube-apiserver port (for the generated kubeconfig)"
  default     = 6443
}
