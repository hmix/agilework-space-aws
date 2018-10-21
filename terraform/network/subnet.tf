# Public subnets
resource "aws_subnet" "public_subnet_eu_central_1a" {
  vpc_id                  = "${aws_vpc.dev.id}"
  cidr_block              = "172.31.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-central-1a"
  tags = {
  	Name =  "Subnet AZ 1a (public)"
  }
}
resource "aws_subnet" "public_subnet_eu_central_1b" {
  vpc_id                  = "${aws_vpc.dev.id}"
  cidr_block              = "172.31.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-central-1b"
  tags = {
  	Name =  "Subnet AZ 1b (public)"
  }
}
resource "aws_subnet" "public_subnet_eu_central_1c" {
  vpc_id                  = "${aws_vpc.dev.id}"
  cidr_block              = "172.31.3.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-central-1c"
  tags = {
  	Name =  "Subnet AZ 1c (public)"
  }
}

# Private subnets
resource "aws_subnet" "private_subnet_eu_central_1a" {
  vpc_id                  = "${aws_vpc.dev.id}"
  cidr_block              = "172.31.11.0/24"
  availability_zone = "eu-central-1a"
  tags = {
  	Name =  "Subnet AZ 1a (private)"
  }
}
resource "aws_subnet" "private_subnet_eu_central_1b" {
  vpc_id                  = "${aws_vpc.dev.id}"
  cidr_block              = "172.31.12.0/24"
  availability_zone = "eu-central-1b"
  tags = {
  	Name =  "Subnet AZ 1b (private)"
  }
}
resource "aws_subnet" "private_subnet_eu_central_1c" {
  vpc_id                  = "${aws_vpc.dev.id}"
  cidr_block              = "172.31.13.0/24"
  availability_zone = "eu-central-1c"
  tags = {
  	Name =  "Subnet AZ 1c (private)"
  }
}

# Internet Gateway and route
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.dev.id}"
  tags {
    Name = "Internet gateway"
  }
}
resource "aws_route" "igw_internet_access" {
  route_table_id         = "${aws_vpc.dev.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}
