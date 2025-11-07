terraform {
  backend "s3" {
    bucket         = "dracanus-tfstate"
    key            = "infra/dev/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "dracanus-tf-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-2"
}

# Example VPC + ECS cluster
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Project = "Dracanus"
    Owner   = "Brian Richter"
    Environment = "dev"
  }
}

resource "aws_ecs_cluster" "dracanus_cluster" {
  name = "dracanus-dev-cluster"
}

# Example RDS instance
resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "15.3"
  instance_class       = "db.t3.micro"
  db_name              = "dracanus"
  username             = "admin"
  password             = "ChangeMe123!"
  skip_final_snapshot  = true
  publicly_accessible  = false
}
