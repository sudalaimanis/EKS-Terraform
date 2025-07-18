variable "subnet_ids" {
  description = "List of subnet IDs for EKS"
  type        = list(string)
}

variable "instance_types" {
  description = "List of subnet IDs for EKS"
  type        = list(string)
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}