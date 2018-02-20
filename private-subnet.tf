/*
  Private Subnet
*/
resource "aws_subnet" "eu-west-2a-private" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "eu-west-2a"

    tags {
        Name = "terraform-aws-private-subnet"
    }
}

resource "aws_route_table" "eu-west-2a-private" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        instance_id = "${aws_instance.nat.id}"
    }

    tags {
        Name = "terraform-aws-private-route-table"
    }
}

resource "aws_route_table_association" "eu-west-2a-private" {
    subnet_id = "${aws_subnet.eu-west-2a-private.id}"
    route_table_id = "${aws_route_table.eu-west-2a-private.id}"
}
