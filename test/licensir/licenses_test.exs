defmodule Licensir.LicensesTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  defmodule DepsApp do
    def project do
      [
        deps: [
          {:dep_one_license, path: "test/fixtures/deps/dep_one_license"},
          {:dep_two_licenses, path: "test/fixtures/deps/dep_two_licenses"},
          {:dep_license_undefined, path: "test/fixtures/deps/dep_license_undefined"},
        ]
      ]
    end
  end

  test "prints list of dependency's licenses" do
    Mix.Project.push(DepsApp)

    output = capture_io(fn ->
      Licensir.Licenses.list()
    end)

    assert output ==
      """
      Licenses listed by their dependency:
      dep_license_undefined    -> License is undefined
      dep_one_license          -> License One
      dep_two_licenses         -> License Two, License Three
      """
  end
end
