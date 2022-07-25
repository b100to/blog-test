# AWS 프로바이더 선언 및 리전, 프로파일 세팅
provider "aws" {
  region  = "ap-northeast-2"
  profile = "dev"
}

#AWS 프로바이더 버전 지정
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.22.0"
    }
  }
}