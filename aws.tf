provider "aws" {
    access_key = ""
    secret_key = ""
    region = "eu-central-1"
}

resource "aws_s3_bucket" "vg_tf_lessons" {
  bucket = "vg-test-bucket-tf-001"
  acl    = "private"
}

resource "aws_db_instance" "vg_tf_lessons" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "vgdb"
  username             = "admin"
  password             = "admin-admin"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "vgtestinstance"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "VG Test"
  }
}
