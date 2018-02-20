/*
  Puppet Instances and Resources
*/

data "template_file" "puppet_user_data" {
    template = "${file("puppet_bootstrap_user_data")}"
}

resource "aws_security_group" "puppet" {
    name = "puppet sg"
    description = "Allow incoming HTTP connections."

    # Ping
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # SSH
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Puppet
    ingress {
        from_port = 8140
        to_port = 8140
        protocol = "tcp"
        cidr_blocks = ["10.10.0.0/16"]
    }

    # Ping
    egress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # SSH
    egress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.10.0.0/16"]
    }

    # HTTP
    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # HTTPS
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "Puppet-Master-Security-Group"
    }
}

resource "aws_instance" "puppet-1" {
    ami = "${lookup(var.ubuntu_1604_amis, var.aws_region)}"
    availability_zone = "${lookup(var.aws_region_azs, var.aws_region)}"
    instance_type = "t2.medium"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.puppet.id}"]
    subnet_id = "${aws_subnet.eu-west-2a-private.id}"
    associate_public_ip_address = true
    source_dest_check = false
    user_data = "${data.template_file.puppet_user_data.rendered}"

    tags {
        Name = "Puppet-Master-Instance"
    }
}

resource "aws_eip" "puppet-1-eip" {
    instance = "${aws_instance.puppet-1.id}"
    vpc = true
}

output "Puppet IP" {
  value = "${aws_eip.puppet-1-eip.private_ip}"
}
