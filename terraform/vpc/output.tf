output "vpc_id" {
    value = aws_vpc.main.id
}

output "public_route_table_id" {
    value = aws_vpc.main.main_route_table_id
}

output "private_route_table_id" {
    value = aws_route_table.private.id
}

output "private_subnets" {
    value = aws_subnet.private
}