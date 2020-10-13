defmodule Licensir.ScannerTest do
  use Licensir.Case

  test "returns a list of Licensir.Licenses struct" do
    licenses = Licensir.Scanner.scan([])

    assert Enum.all?(licenses, fn license ->
             license.__struct__ == Licensir.License
           end)
  end

  test "returns a list of Licensir.TestApp's licenses" do
    licenses = Licensir.Scanner.scan([])

    assert has_license?(licenses, %{app: :dep_one_license})
    assert has_license?(licenses, %{app: :dep_two_licenses})
    assert has_license?(licenses, %{app: :dep_license_undefined})
  end

  test "can filter Licensir.TestApp's dependencies for top-level only" do
    licenses = Licensir.Scanner.scan([top_level_only: true])

    assert has_license?(licenses, %{app: :dep_with_dep})
    refute has_license?(licenses, %{app: :dep_of_dep})
  end

  test "returns the acceptability of the license" do
    licenses = Licensir.Scanner.scan([config_file: "test/fixtures/licensir-config.exs"])

    not_allowed_license = Enum.find(licenses, & &1.name == "dep_one_license")
    assert not_allowed_license.status == :not_allowed

    unknown_license = Enum.find(licenses, & &1.name == "dep_license_undefined")
    assert unknown_license.status == :unknown

    allowed_license = Enum.find(licenses, & &1.name == "dep_two_variants_same_license")
    assert allowed_license.status == :allowed

    allowed_app = Enum.find(licenses, & &1.name == "dep_mock_license")
    assert allowed_app.status == :allowed
  end

  defp has_license?(licenses, search_map) do
    Enum.any?(licenses, fn license ->
      Map.merge(license, search_map) == license
    end)
  end
end
