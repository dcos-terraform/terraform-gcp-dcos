output "infrastructure_bootstrap_os_user" {
  description = "Bootstrap instance OS default user"
  value       = module.dcos-infrastructure.bootstrap_os_user
}

output "infrastructure_masters_os_user" {
  description = "Master instances OS default user"
  value       = module.dcos-infrastructure.masters_os_user
}

output "infrastructure_forwarding_rules_masters" {
  description = "Master Forwarding Rules"
  value       = module.dcos-infrastructure.forwarding_rules_masters
}

output "infrastructure_forwarding_rules_public_agents" {
  description = "Public Agent Forwarding Rules"
  value       = module.dcos-infrastructure.forwarding_rules_public_agents
}

output "infrastructure_private_agents_os_user" {
  description = "Private Agent instances OS default user"
  value       = module.dcos-infrastructure.private_agents_os_user
}

output "infrastructure_public_agents_os_user" {
  description = "Public Agent instances OS default user"
  value       = module.dcos-infrastructure.public_agents_os_user
}

output "infrastructure_bootstrap_private_ip" {
  description = "Private IP of the bootstrap instance"
  value       = module.dcos-infrastructure.bootstrap_private_ip
}

output "infrastructure_bootstrap_public_ip" {
  description = "Public IP of the bootstrap instance"
  value       = module.dcos-infrastructure.bootstrap_public_ip
}

output "infrastructure_masters_zone_list" {
  description = "Master instances zone list"
  value       = module.dcos-infrastructure.masters_zone_list
}

output "infrastructure_masters_public_ips" {
  description = "Master instances public IPs"
  value       = module.dcos-infrastructure.masters_public_ips
}

output "infrastructure_masters_private_ips" {
  description = "Master instances private IPs"
  value       = module.dcos-infrastructure.masters_private_ips
}

output "infrastructure_masters_subnetwork_name" {
  description = "Master instances subnetwork name"
  value       = module.dcos-infrastructure.masters_subnetwork_name
}

output "infrastructure_private_agents_zone_list" {
  description = "Private Agent zone list"
  value       = module.dcos-infrastructure.private_agents_zone_list
}

output "infrastructure_private_agents_public_ips" {
  description = "Private Agent public IPs"
  value       = module.dcos-infrastructure.private_agents_public_ips
}

output "infrastructure_private_agents_private_ips" {
  description = "Private Agent instances private IPs"
  value       = module.dcos-infrastructure.private_agents_private_ips
}

output "infrastructure_private_agents_subnetwork_name" {
  description = "Private Agent instances subnetwork name"
  value       = module.dcos-infrastructure.private_agents_subnetwork_name
}

output "infrastructure_public_agents_zone_list" {
  description = "Public Agent zone list"
  value       = module.dcos-infrastructure.public_agents_zone_list
}

output "infrastructure_public_agents_public_ips" {
  description = "Public Agent public IPs"
  value       = module.dcos-infrastructure.public_agents_public_ips
}

output "infrastructure_public_agents_private_ips" {
  description = "Public Agent instances private IPs"
  value       = module.dcos-infrastructure.public_agents_private_ips
}

output "infrastructure_public_agents_subnetwork_name" {
  description = "Public Agent instances subnetwork name"
  value       = module.dcos-infrastructure.public_agents_subnetwork_name
}

output "infrastructure_network_self_link" {
  description = "Self link of created network"
  value       = module.dcos-infrastructure.network_self_link
}
