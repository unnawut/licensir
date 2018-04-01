defmodule Licensir.Mix.Tasks.LicensesTest do
  use Licensir.Case
  import ExUnit.CaptureIO

  test "prints a list of dependencies and their licenses" do
    output = capture_io(fn ->
      Mix.Tasks.Licenses.run([])
    end)

    assert output ==
      """
      dep_license_undefined   -> Undefined
      dep_one_license         -> License One
      dep_two_licenses        -> License Two, License Three
      """
  end
end
