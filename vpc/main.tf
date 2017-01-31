####### VPC

resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr_block}"

  tags {
    Name = "${var.environment}-${var.project_name}"
    Environment = "${var.environment}"
    ProjectName = "${var.project_name}"
  }
}

####### Subnets

resource "aws_subnet" "main-subnet-1" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet_az_1-cidr}"
  availability_zone = "${var.subnet_az_1-az_name}"

  tags {
    Name = "${var.environment}-${var.project_name}"
    Environment = "${var.environment}"
    ProjectName = "${var.project_name}"
  }
}

resource "aws_subnet" "main-subnet-2" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet_az_2-cidr}"
  availability_zone = "${var.subnet_az_2-az_name}"

  tags {
    Name = "${var.environment}-${var.project_name}"
    Environment = "${var.environment}"
    ProjectName = "${var.project_name}"
  }
}

resource "aws_subnet" "main-subnet-3" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet_az_3-cidr}"
  availability_zone = "${var.subnet_az_3-az_name}"

  tags {
    Name = "${var.environment}-${var.project_name}"
    Environment = "${var.environment}"
    ProjectName = "${var.project_name}"
  }
}

resource "aws_subnet" "main-subnet-4" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet_az_4-cidr}"
  availability_zone = "${var.subnet_az_4-az_name}"

  tags {
    Name = "${var.environment}-${var.project_name}"
    Environment = "${var.environment}"
    ProjectName = "${var.project_name}"
  }
}

####### Internet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.environment}-${var.project_name}"
    Environment = "${var.environment}"
    ProjectName = "${var.project_name}"
  }
}

####### Security Groups

resource "aws_security_group" "main-ingress-ssh" {
  name = "main-ingress-ssh"
  description = "Allow ingress ssh for main vpc"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.environment}-${var.project_name}"
    Environment = "${var.environment}"
    ProjectName = "${var.project_name}"
  }
}

resource "aws_security_group" "main-ingress-http" {
  name = "main-ingress-http"
  description = "Allow ingress http for main vpc"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.environment}-${var.project_name}"
    Environment = "${var.environment}"
    ProjectName = "${var.project_name}"
  }
}

resource "aws_security_group" "main-ingress-https" {
  name = "main-ingress-https"
  description = "Allow ingress https for main vpc"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.environment}-${var.project_name}"
    Environment = "${var.environment}"
    ProjectName = "${var.project_name}"
  }
}

resource "aws_security_group" "main-egress-all" {
  name = "main-egress-all"
  description = "Allow egress all for main vpc"
  vpc_id = "${aws_vpc.main.id}"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.environment}-${var.project_name}"
    Environment = "${var.environment}"
    ProjectName = "${var.project_name}"
  }
}

####### Default VPC security group

resource "aws_default_security_group" "default" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.environment}-${var.project_name}"
    Environment = "${var.environment}"
    ProjectName = "${var.project_name}"
  }
}

####### Route

resource "aws_route" "r" {
  route_table_id = "${aws_vpc.main.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.gw.id}"
}

####### EC2 Instance
//
//resource "aws_instance" "web" {
//  # The connection block tells our provisioner how to
//  # communicate with the resource (instance)
//  connection {
//    # The default username for our AMI
//    user = "ubuntu"
//
//    # The connection will use the local SSH agent for authentication.
//  }
//
//  instance_type = "t2.micro"
//
//  # Lookup the correct AMI based on the region
//  # we specified
//  ami = "${lookup(var.aws_amis, var.aws_region)}"
//
//  # The name of our SSH keypair we created above.
//  key_name = "${aws_key_pair.auth.id}"
//
//  # Our Security group to allow HTTP and SSH access
//  vpc_security_group_ids = [
//    "${aws_security_group.main-ingress-http.id}",
//    "${aws_security_group.main-ingress-ssh.id}"
//  ]
//
//  # We're going to launch into the same subnet as our ELB. In a production
//  # environment it's more common to have a separate private subnet for
//  # backend instances.
//  subnet_id = "${aws_internet_gateway.gw.}"
//
//  # We run a remote provisioner on the instance after creating it.
//  # In this case, we just install nginx and start it. By default,
//  # this should be on port 80
//  provisioner "remote-exec" {
//    inline = [
//      "sudo apt-get -y update",
//      "sudo apt-get -y install nginx",
//      "sudo service nginx start",
//    ]
//  }
//}