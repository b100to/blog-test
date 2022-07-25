#TG 생성 - 서비스 핼스체크 및 private IP 테이블 역할(?) 담당
resource "aws_lb_target_group" "this" {
  name                          = "test-blog123"
  vpc_id                        = data.aws_vpc.this.id
  target_type                   = "ip"
  load_balancing_algorithm_type = "round_robin"
  port                          = 80
  deregistration_delay          = "5"
  protocol                      = "HTTP"
  protocol_version              = "HTTP1"
  slow_start                    = 0
  tags                          = {}

  health_check {
    protocol            = "HTTP"
    port                = "traffic-port"
    path                = "/"
    enabled             = true
    matcher             = "200"
    interval            = 5
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  stickiness {
    cookie_duration = 86400
    enabled         = false
    type            = "lb_cookie"
  }
}

#ALB 생성 - 자체 생성 된 DNS를 통하여 HTTP로 외부와 인터넷 연결 가능
resource "aws_lb" "this" {
  name                   = "test-blog123"
  load_balancer_type     = "application"
  ip_address_type        = "ipv4"
  desync_mitigation_mode = "defensive"
  subnets = [
    data.aws_subnet.public1.id
    , data.aws_subnet.public2.id
  ]
  security_groups = [
    data.aws_security_group.this.id
  ]
  idle_timeout               = 60
  drop_invalid_header_fields = false
  enable_deletion_protection = false
  enable_http2               = true
  enable_waf_fail_open       = false
  internal                   = false
  tags                       = {}
}

#LB 리스너 생성 - LB과 TG을 연결 시켜준다.
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"
  tags              = {}

  default_action {
    target_group_arn = aws_lb_target_group.this.arn
    type             = "forward"
  }
}