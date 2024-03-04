mock "tfplan/v2" {
  module {
    source = "../../testdata/mock-tfplan-v2.sentinel"
  }
}

test {
    rules = {
        main = true
    }
}
