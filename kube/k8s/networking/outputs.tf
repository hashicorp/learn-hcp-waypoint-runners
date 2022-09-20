output "subnet_ids" {
 value = {
    private = aws_subnet.private.id
    public = aws_subnet.public.id
  }
}
output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "route_table_id" {
  value = aws_route_table.private.id
}
output "main_route_table_id" {
  value = aws_route_table.main.id
}

output "public-subnet-id" {
  value = aws_subnet.public.id
}

output "private-subnet-id" {
  value = aws_subnet.private.id
}