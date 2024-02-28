#module "dev_cluster" {
#    source     = "./base"
#    env_name   = "dev"
#    project_id = "${var.project_id}"
#    instance_type = "e2-medium"
#}
 
#module "staging_cluster" {
#    source     = "./base"
#    env_name   = "staging"
#    project_id = "${var.project_id}"
#    instance_type = "e2-medium"
#}
 
module "prod_cluster" {
    source     = "./base"
    env_name   = "prod"
    project_id = "masondenney-my-gke"
    instance_type = "e2-medium"
}

#variable "project_id" {
#  description = "The project ID to host the cluster in"
#}
