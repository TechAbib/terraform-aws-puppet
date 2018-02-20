resource "aws_route53_zone" "dev" {
  name = "local"
  vpc_id = "${aws_vpc.default.id}"
}

resource "aws_route53_record" "puppet-master" {
  zone_id = "${aws_route53_zone.dev.zone_id}"
  name    = "puppet-master"
  type    = "A"
  records = ["${aws_eip.puppet-1-eip.private_ip}"]
  ttl     = "360"
}
