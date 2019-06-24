defmodule Licensir.TestApp do
  def project do
    [
      deps: [
        {:dep_with_dep, path: "test/fixtures/deps/dep_with_dep"},
        {:dep_one_license, path: "test/fixtures/deps/dep_one_license"},
        {:dep_two_licenses, path: "test/fixtures/deps/dep_two_licenses"},
        {:dep_license_undefined, path: "test/fixtures/deps/dep_license_undefined"},
        {:dep_two_variants_same_license, path: "test/fixtures/deps/dep_two_variants_same_license"},
        {:dep_two_conflicting_licenses, path: "test/fixtures/deps/dep_two_conflicting_licenses"},
        {:dep_one_unrecognized_license_file, path: "test/fixtures/deps/dep_one_unrecognized_license_file"}
      ]
    ]
  end
end
