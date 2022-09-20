output "lb_address_consul_nomad" {
  value = "http://${aws_elb.server_lb.dns_name}"
}

output "consul_bootstrap_token_secret" {
  value = var.nomad_consul_token_secret
}

output "nomad_client_network_ids" {
  value = aws_instance.client[*].primary_network_interface_id
}

output "nomad_vpc_id" {
  value = data.aws_vpc.default.id
}

output "nomad_client_ips" {
  value = "${join(", ", aws_instance.client[*].public_ip)}"
}

output "IP_Addresses" {
  value = <<CONFIGURATION

Client public IPs: ${join(", ", aws_instance.client[*].public_ip)}

Server public IPs: ${join(", ", aws_instance.server[*].public_ip)}

The Consul UI can be accessed at http://${aws_elb.server_lb.dns_name}:8500/ui
with the bootstrap token: ${var.nomad_consul_token_secret}
CONFIGURATION
}
