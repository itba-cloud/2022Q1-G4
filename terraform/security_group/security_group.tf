resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
        description      = try(ingress.value.description,"")
        from_port        = ingress.value.from_port
        to_port          = ingress.value.to_port
        protocol         = ingress.value.protocol
        cidr_blocks      = ingress.value.cidr_blocks
        security_groups  = try(ingress.value.security_groups,null)
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules

    content {
        description      = try(egress.value.description,"")
        from_port        = egress.value.from_port
        to_port          = egress.value.to_port
        protocol         = egress.value.protocol
        cidr_blocks      = egress.value.cidr_blocks
        security_groups  = try(egress.value.security_groups,null)
    }
  }
#   ingress {
#     description      = "TLS from VPC"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = [aws_vpc.main.cidr_block]
#     ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

  tags = {
    Name = "allow_tls"
  }
}