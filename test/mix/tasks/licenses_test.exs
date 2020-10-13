defmodule Licensir.Mix.Tasks.LicensesTest do
  use Licensir.Case
  import ExUnit.CaptureIO

  test "prints a list of dependencies and their licenses" do
    output =
      capture_io(fn ->
        Mix.Tasks.Licenses.run([])
      end)

    expected =
      IO.ANSI.format_fragment([
        [:yellow, "Notice: This is not a legal advice. Use the information below at your own risk."], :reset, "\n",
        "+-----------------------------------+---------+----------------------------------------------------+---------+", "\n",
        "| Package                           | Version | License                                            | Status  |", "\n",
        "+-----------------------------------+---------+----------------------------------------------------+---------+", "\n",
        "| dep_license_undefined             |         | Undefined                                          | Unknown |", "\n",
        "| dep_mock_license                  |         | Licensir Mock License                              | Unknown |", "\n",
        "| dep_of_dep                        |         | Undefined                                          | Unknown |", "\n",
        "| dep_one_license                   |         | Licensir Mock License                              | Unknown |", "\n",
        "| dep_one_unrecognized_license_file |         | Unrecognized license file content                  | Unknown |", "\n",
        "| dep_two_conflicting_licenses      |         | Unsure (found: License One, Licensir Mock License) | Unknown |", "\n",
        "| dep_two_licenses                  |         | License Two, License Three                         | Unknown |", "\n",
        "| dep_two_variants_same_license     |         | Apache 2.0                                         | Unknown |", "\n",
        "| dep_with_dep                      |         | Undefined                                          | Unknown |", "\n",
        "+-----------------------------------+---------+----------------------------------------------------+---------+", "\n", "\n"
      ])
      |> to_string()

    assert output == expected
  end

  test "prints csv format when given --csv flag" do
    output =
      capture_io(fn ->
        Mix.Tasks.Licenses.run(["--csv"])
      end)

    expected =
      """
      Package,Version,License,Status\r
      dep_license_undefined,,Undefined,Unknown\r
      dep_mock_license,,Licensir Mock License,Unknown\r
      dep_of_dep,,Undefined,Unknown\r
      dep_one_license,,Licensir Mock License,Unknown\r
      dep_one_unrecognized_license_file,,Unrecognized license file content,Unknown\r
      dep_two_conflicting_licenses,,"Unsure (found: License One, Licensir Mock License)",Unknown\r
      dep_two_licenses,,"License Two, License Three",Unknown\r
      dep_two_variants_same_license,,Apache 2.0,Unknown\r
      dep_with_dep,,Undefined,Unknown\r
      """

    assert output == expected
  end
end
