# This is the "Root Module" call for the Dev Environment
module "networking" {
  # 1. Path to the blueprint logic
  source = "../../modules/networking"

  # 2. Input variables required by the module
  vpc_cidr    = var.vpc_cidr
  environment = "dev"

  # 3. Networking specifics
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.10.0/24", "10.0.11.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
}