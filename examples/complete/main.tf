module "aci_port_tracking" {
  source  = "netascode/port-tracking/aci"
  version = ">= 0.0.1"

  admin_state = true
  delay       = 5
  min_links   = 2
}
