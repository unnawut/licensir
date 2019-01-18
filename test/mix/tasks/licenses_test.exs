defmodule Licensir.Mix.Tasks.LicensesTest do
  use Licensir.Case
  import ExUnit.CaptureIO

  test "prints a list of dependencies and their licenses" do
    output =
      capture_io(fn ->
        Mix.Tasks.Licenses.run([])
      end)

    notice = "Notice: This is not a legal advice. Use the information below at your own risk.\n"

    content =
      IO.ANSI.format([
        "dep_license_undefined   -> ", [:red, "Undefined"], :reset, "\n",
        "dep_one_license         -> ", [:green, "License One"], :reset, "\n",
        "dep_two_licenses        -> ", [:green, "License Two, License Three"], :reset, "\n",
        "dep_two_variants_same_license -> ", [:green, "Apache 2.0"], :reset, "\n"
      ])
      |> to_string()
      |> Kernel.<>("\n")

    expected = notice <> content

    assert output == expected
  end
end
