terraform {
  required_version = ">= 1.0.0"

  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
}

module "main" {
  source = "../.."

  admin_state = true
}

data "aci_rest_managed" "infraPortTrackPol" {
  dn = "uni/infra/trackEqptFabP-default"

  depends_on = [module.main]
}

resource "test_assertions" "infraPortTrackPol" {
  component = "infraPortTrackPol"

  equal "adminSt" {
    description = "adminSt"
    got         = data.aci_rest_managed.infraPortTrackPol.content.adminSt
    want        = "on"
  }
}
