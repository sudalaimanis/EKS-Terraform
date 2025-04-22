output "cluster_id" {
  value = aws_eks_cluster.sudalai.id
}

output "node_group_id" {
  value = aws_eks_node_group.sudalai.id
}

output "vpc_id" {
  value = aws_vpc.sudalai_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.sudalai_subnet[*].id
}

