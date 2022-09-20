terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.66.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = var.default_tags
  }
}

module "primary_kubernetes" {
  source                       = "./k8s"
  eks_cluster_name             = var.eks_cluster_name_primary
  eks_vpc_cidr_block           = var.eks_cluster_primary_ips
  eks_vpc_cidr_block_primary   = var.eks_cluster_primary_ips
  eks_primary_cluster          = var.eks_cluster_name_primary
  availability_zones           = var.availability_zones

}


module "cleanup_infra_primary" {
    source = "github.com/webdog/terraform-kubernetes-delete-eni"
    vpc_id = module.primary_kubernetes.vpc_id
    region = var.aws_region
}