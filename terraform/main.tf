#ECS 클러스터 생성
resource "aws_ecs_cluster" "this" {
  name     = "blog-test"
  tags     = {}
  tags_all = {}

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecr_repository" "this" {
  image_tag_mutability = "MUTABLE"
  name                 = "blog-test"
  tags                 = {}

  image_scanning_configuration {
    scan_on_push = false
  }
}

#테스크 정의 생성 - Task 스펙 설정
resource "aws_ecs_task_definition" "this" {
  family       = "test-blog"
  cpu          = "512"
  memory       = "1024"
  network_mode = "awsvpc"
  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
  requires_compatibilities = [
    "FARGATE",
  ]
  task_role_arn      = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/CloudEcsTaskRole"
  execution_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ecsTaskExecutionRole"
  container_definitions = jsonencode(
    [
      {
        cpu         = 0
        environment = []
        essential   = true
        image       = "${data.aws_caller_identity.current.account_id}.dkr.ecr.ap-northeast-2.amazonaws.com/blog-test:latest"
        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-group         = "/ecs/test-blog"
            awslogs-region        = "ap-northeast-2"
            awslogs-stream-prefix = "ecs"
          }
        }
        mountPoints = []
        name        = "app"
        portMappings = [
          {
            containerPort = 8080
            hostPort      = 8080
            protocol      = "tcp"
          },
        ]
        volumesFrom = []
      },
    ]
  )
  tags = {
    "ecs:taskDefinition:createdFrom" = "ecs-console-v2"
    "ecs:taskDefinition:stackId"     = "arn:aws:cloudformation:ap-northeast-2:${data.aws_caller_identity.current.account_id}:stack/ECS-Console-V2-TaskDefinition-4bcedecd-24f5-4570-8d0c-936d1acd52cc/1c346740-fcd6-11ec-bfdb-02068544a002"
  }
}

#ECS 서비스 생성
resource "aws_ecs_service" "this" {
  name                               = "test-blog123"
  cluster                            = aws_ecs_cluster.this.arn
  iam_role                           = "aws-service-role"
  desired_count                      = 1
  health_check_grace_period_seconds  = 60
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  task_definition                    = "${aws_ecs_task_definition.this.id}:${aws_ecs_task_definition.this.revision}"
  tags                               = {}

  # 스팟 얼마나 줄것인지
  capacity_provider_strategy {
    base              = 0
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }

  # LB 세팅
  load_balancer {
    container_name   = "app"
    container_port   = 8080
    target_group_arn = aws_lb_target_group.this.arn
  }

  # 네트워크 세팅
  network_configuration {
    assign_public_ip = true
    security_groups = [
      data.aws_security_group.this.id
    ]
    subnets = [
      data.aws_subnet.private1.id,
      data.aws_subnet.private2.id
    ]
  }
}
