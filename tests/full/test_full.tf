terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  admin_state = true
  delay       = 5
  min_links   = 2
}

data "aci_rest" "infraPortTrackPol" {
  dn = "uni/infra/trackEqptFabP-default"

  depends_on = [module.main]
}

resource "test_assertions" "infraPortTrackPol" {
  component = "infraPortTrackPol"

  equal "adminSt" {
    description = "adminSt"
    got         = data.aci_rest.infraPortTrackPol.content.adminSt
    want        = "on"
  }

  equal "delay" {
    description = "delay"
    got         = data.aci_rest.infraPortTrackPol.content.delay
    want        = "5"
  }

  equal "minlinks" {
    description = "minlinks"
    got         = data.aci_rest.infraPortTrackPol.content.minlinks
    want        = "2"
  }
}
