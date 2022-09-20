variable "eks_cluster_name_primary" {
  description = "Name of the primary EKS Cluster"
  type        = string
  default     = "wp-eks-cluster"
}

# Default tags to pass to AWS. You can set them here, or in a tfvars file.
variable "default_tags" {
  type = map(string)
  default = {
    environment = "waypoint-lab"
  }
}

variable "eks_cluster_primary_ips" {
  description = "The CIDR groups for the Primary Cluster's IP addresses"
  default = {
    vpc      = "10.100.0.0/16"
    private  = "10.100.1.0/24"
    public   = "10.100.2.0/24"
    internet = "0.0.0.0/0"
  }
}

variable "aws_region" {
  default = "ca-central-1"
  type    = string
}

variable "availability_zones" {
  description = "The AZs in which the Clusters will deploy"
  default = {
    zone_one = "ca-central-1a"
    zone_two = "ca-central-1b"
  }
}
