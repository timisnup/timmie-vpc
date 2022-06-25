resource "aws_vpc" "timmie-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "timmie-vpc"
  }
}


#Public subnet 
resource "aws_subnet" "public-sub-1" {
  vpc_id     = aws_vpc.timmie-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public-sub-1"
  }
}


#public subnet
resource "aws_subnet" "public-sub-2" {
  vpc_id     = aws_vpc.timmie-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public-sub-2"
  }
}


#Private subnet
resource "aws_subnet" "private-sub-1" {
  vpc_id     = aws_vpc.timmie-vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "private-sub-1"
  }
}


#private subnet
resource "aws_subnet" "private-sub-2" {
  vpc_id     = aws_vpc.timmie-vpc.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "private-sub-2"
  }
}



#Public route table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.timmie-vpc.id
  tags = {
    Name = "public-rt"
  }
}



#Private route table
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.timmie-vpc.id
  tags = {
    Name = "private-rt"
  }
}


#public route table association
resource "aws_route_table_association" "public-route-1-association" {
  subnet_id      = aws_subnet.public-sub-1.id
  route_table_id = aws_route_table.public-rt.id
}


#public route table association
resource "aws_route_table_association" "public-route-2-association" {
  subnet_id      = aws_subnet.public-sub-2.id
  route_table_id = aws_route_table.public-rt.id
}


#private route table association
resource "aws_route_table_association" "private-route-1-association" {
  subnet_id      = aws_subnet.private-sub-1.id
  route_table_id = aws_route_table.public-rt.id
}


#private route table association
resource "aws_route_table_association" "privte-route-2-association" {
  subnet_id      = aws_subnet.private-sub-2.id
  route_table_id = aws_route_table.private-rt.id
}


#Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.timmie-vpc.id

  tags = {
    Name = "igw"
  }
}


resource "aws_route" "public-igw-route" {
  route_table_id         = aws_route_table.public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

}