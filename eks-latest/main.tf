
terraform {
  backend "s3" {
    bucket         = "terraend-bucket-testing-sudlai"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terralocksudalai"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block               =  var.cidr_block
  public_subnet_az1_cidr   =  var.public_subnet_az1_cidr
  public_subnet_az2_cidr   =  var.public_subnet_az2_cidr
  private_subnet_az1_cidr  =  var.private_subnet_az1_cidr
  private_subnet_az2_cidr  =  var.private_subnet_az2_cidr
}

module "eks" {
  source     = "./modules/eks"
  subnet_ids = module.vpc.private_subnet_ids
  instance_types = var.instance_types
  cluster_name = var.cluster_name
}