output "masters-loadbalancer" {
  description = "This is the load balancer address to access the DC/OS UI"
  value       = "${module.dcos-infrastructure.forwarding_rules.masters}"
}
