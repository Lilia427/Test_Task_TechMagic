resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge({ "Name" = "${var.prefix}-vpc" }, var.common_tags)
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge({ "Name" = "${var.prefix}-IGW" }, var.common_tags)
}

resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_a_cidr_block
  availability_zone = "${var.region}a"

  tags = merge({ "Name" = "${var.prefix}-subnet-a" }, var.common_tags)
}

resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_b_cidr_block
  availability_zone = "${var.region}b"

  tags = merge({ "Name" = "${var.prefix}-subnet-b" }, var.common_tags)
}

resource "aws_subnet" "subnet_c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_c_cidr_block
  availability_zone = "${var.region}c"

  tags = merge({ "Name" = "${var.prefix}-subnet-c" }, var.common_tags)
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge({ "Name" = "${var.prefix}-route-table" }, var.common_tags)
}

resource "aws_route_table_association" "sub_a" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "sub_b" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "sub_c" {
  subnet_id      = aws_subnet.subnet_c.id
  route_table_id = aws_route_table.route_table.id
}
