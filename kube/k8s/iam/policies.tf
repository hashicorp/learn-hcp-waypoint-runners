# The overall policy that the following resources are being attached to.
resource "aws_iam_policy" "eks" {
  policy = local.open_policy
}

resource "aws_iam_policy_attachment" "EKSWorkerNodePolicy" {
  name       = "eks/eks-worker-node-policy"
  roles = [
    aws_iam_role.eks.name
  ]
  policy_arn = var.eks_worker_node_policy_arn
}

resource "aws_iam_policy_attachment" "EKSCNIPolicy" {
  name = "eks/eks-cni-policy"
  roles = [
    aws_iam_role.eks.name
  ]
  policy_arn = var.eks_cni_policy_arn
}

resource "aws_iam_policy_attachment" "EC2ContainerRegistryReadOnly" {
  name       = "eks/ec2-container-registry-read-only"
  roles = [
    aws_iam_role.eks.name
  ]
  policy_arn = var.ec2_container_registry_read_only_policy_arn
}

resource "aws_iam_policy_attachment" "EKSClusterPolicy" {
  name       = "eks/eks-cluster-policy"
  roles = [
    aws_iam_role.eks.name
  ]
  policy_arn = var.eks_cluster_policy_arn
}