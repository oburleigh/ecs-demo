#====================================Core Variables===============
core_name               = "webapp"
map_public_ip_on_launch = true
tags = {
  Input = "demo"
}
vpc_cidr_block           = "10.0.0.0/16"
public_subnet_cidr_block = "10.0.1.0/24"

#====================================ECR Variables
ecr_build_path = "../images/nginx"
ecr_image      = "nginx"
ecr_image_tag  = "latest"

#==================================ECS Variables
ecs_cluster_name   = "webapp"
capacity_providers = ["FARGATE_SPOT", "FARGATE"]

#==================================ECS Service Variables
ecs_service_name          = "webappservice"
ecs_service_launch_type   = "FARGATE"
ecs_service_desired_count = 1
ecs_service_assign_pub_ip = true

#==================================ECS Task Variables
ecs_task_family        = "demoFamily"
ecs_task_network_mode  = "awsvpc"
ecs_task_req_compat    = ["FARGATE"]
ecs_task_cpu           = 256
ecs_task_mem           = 512
ecs_task_container_mem = 512
ecs_task_container_cpu = 256
ecs_task_name          = "webtask"
