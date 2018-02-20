/*
  Public Subnet
*/
resource "aws_subnet" "eu-west-2a-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "eu-west-2a"

    tags {
        Name = "terraform-aws-public-subnet"
    }
}

resource "aws_route_table" "eu-west-2a-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "terraform-aws-public-route-table"
    }
}

resource "aws_route_table_association" "eu-west-2a-public" {
    subnet_id = "${aws_subnet.eu-west-2a-public.id}"
    route_table_id = "${aws_route_table.eu-west-2a-public.id}"
}
