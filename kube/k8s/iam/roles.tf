resource "aws_iam_role" "eks" {
  assume_role_policy = local.assume_policy
  managed_policy_arns = [
    aws_iam_policy.eks.arn,
    var.eks_cluster_policy_arn,
  ]
}
