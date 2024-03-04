policy "restrict-ec2-instance-type" {
    source = "./restrict-ec2-instance-type.sentinel"
    enforcement_level = "hard-mandatorry"
}

mock "tfconfig" {
  module {
    source = "testdata/mock-tfconfig.sentinel"
  }
}

mock "tfconfig/v1" {
  module {
    source = "testdata/mock-tfconfig.sentinel"
  }
}

mock "tfconfig/v2" {
  module {
    source = "testdata/mock-tfconfig-v2.sentinel"
  }
}

mock "tfplan" {
  module {
    source = "testdata/mock-tfplan.sentinel"
  }
}

mock "tfplan/v1" {
  module {
    source = "testdata/mock-tfplan.sentinel"
  }
}

mock "tfplan/v2" {
  module {
    source = "testdata/mock-tfplan-v2.sentinel"
  }
}

mock "tfstate" {
  module {
    source = "testdata/mock-tfstate.sentinel"
  }
}

mock "tfstate/v1" {
  module {
    source = "testdata/mock-tfstate.sentinel"
  }
}

mock "tfstate/v2" {
  module {
    source = "testdata/mock-tfstate-v2.sentinel"
  }
}

mock "tfrun" {
  module {
    source = "testdata/mock-tfrun.sentinel"
  }
}
