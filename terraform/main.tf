module "network" {
  source       = "./modules/network"
  project_name = var.project_name
}

module "server" {
  source           = "./modules/server"
  project_name     = var.project_name
  vpc_id           = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_ids[0]
  key_name         = var.key_name
}

module "eks" {
  source             = "./modules/eks"
  project_name       = var.project_name
  private_subnet_ids = module.network.private_subnet_ids
}

module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
}