#creating a container registry

resource "aws_ecr_repository" "rock_on_ecr_rep" {
  name                 = "rock-on-rep"
}

#creating ECS cluster

resource "aws_ecs_cluster" "Rock_on_ecs" {
  name = "Rock-on-ecs"
}


#creating ECS task definition 

resource "aws_ecs_task_definition" "Rock_on_TD" {
  family = "Rock_on_TD"
  container_definitions = jsonencode([
    {
      name      = "Rock_on_1"
      image     = "Rock_on-first"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    },
    {
      name      = "Rock_on_2"
      image     = "Rock_on-second"
      cpu       = 10
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = 443
          hostPort      = 443
        }
      ]
    }
  ])

  volume {
    name      = "Rock_on-storage"
    host_path = "/ecs/Rock_on-storage"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [eu-west-2a, eu-west-2b]"
  }
}

#creating ECS service

resource "aws_ecs_service" "Rock_on" {
  name            = "Rock_on"
  cluster         = aws_ecs_cluster.Rock_on_ecs.id
  task_definition = aws_ecs_task_definition.Rock_on_TD.arn
  desired_count   = 3
}

output "mysql_endpoint" {
  value = aws_db_instance.rock_on_database.endpoint
}

output "ecr_repository_worker_endpoint" {
  value = aws_ecr_repository.rock_on_ecr_rep.repository_url
}