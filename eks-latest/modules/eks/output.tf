output "cluster_name" {
  description = "EKS Cluster name"
  value       = aws_eks_cluster.my_eks.name
}

output "cluster_endpoint" {
  description = "EKS Cluster endpoint"
  value       = aws_eks_cluster.my_eks.endpoint
}

output "cluster_arn" {
  description = "EKS Cluster ARN"
  value       = aws_eks_cluster.my_eks.arn
}

output "cluster_certificate_authority_data" {
  description = "EKS Cluster CA data"
  value       = aws_eks_cluster.my_eks.certificate_authority[0].data
}