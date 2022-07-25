#AWS ID
data "aws_caller_identity" "current" {}

#기존 VPC
data "aws_vpc" "this" {
  id = var.vpc_id
}


#기존 퍼블릭 서브넷a
data "aws_subnet" "public1" {
  id = var.public_subnet1
}

#기존 퍼블릭 서브넷c
data "aws_subnet" "public2" {
  id = var.public_subnet2
}

#기존 프라이빗 서브넷a
data "aws_subnet" "private1" {
  id = var.private_subnet1
}

#기존 프라이빗 서브넷c
data "aws_subnet" "private2" {
  id = var.private_subnet2
}

#기존 SG
data "aws_security_group" "this" {
  id = var.sg_id
}