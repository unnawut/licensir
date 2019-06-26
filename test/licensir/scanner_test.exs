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

  defp has_license?(licenses, search_map) do
    Enum.any?(licenses, fn license ->
      Map.merge(license, search_map) == license
    end)
  end
end
