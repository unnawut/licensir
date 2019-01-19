defmodule Licensir.Mix.Tasks.LicensesTest do
  use Licensir.Case
  import ExUnit.CaptureIO

  test "prints a list of dependencies and their licenses" do
    output =
      capture_io(fn ->
        Mix.Tasks.Licenses.run([])
      end)

    expected =
      IO.ANSI.format([
        [:yellow, "Notice: This is not a legal advice. Use the information below at your own risk."], :reset, "\n",
        "dep_license_undefined   -> ", [:red, "Undefined"], :reset, "\n",
        "dep_one_license         -> ", [:green, "Licensir Mock License"], :reset, "\n",
        "dep_one_unrecognized_license_file -> ", [:red, "Unrecognized license file content"], :reset, "\n",
        "dep_two_conflicting_licenses -> ", [:yellow, "Unsure (found: License One, Licensir Mock License)"], :reset, "\n",
        "dep_two_licenses        -> ", [:green, "License Two, License Three"], :reset, "\n",
        "dep_two_variants_same_license -> ", [:green, "Apache 2.0"], :reset, "\n"
      ])
      |> to_string()
      |> Kernel.<>("\n")

    assert output == expected
  end
end
