defmodule Licensir.Mix.Tasks.LicensesTest do
  use Licensir.Case
  import ExUnit.CaptureIO

  test "prints a list of dependencies and their licenses" do
    output =
      capture_io(fn ->
        Mix.Tasks.Licenses.run(["--only_license=true"])
      end)

    expected =
      IO.ANSI.format_fragment([
        [
          :yellow,
          "Notice: This is not a legal advice. Use the information below at your own risk."
        ],
        :reset,
        "\n",
        # "|---------------------------------|----------------------------------------------------|",
        "\n",
        "| Package                           | License                                            |",
        "\n",
        "|-----------------------------------|----------------------------------------------------|",
        "\n",
        "| dep_license_undefined             | Undefined                                          |",
        "\n",
        "| dep_of_dep                        | Undefined                                          |",
        "\n",
        "| dep_one_license                   | Licensir Mock License                              |",
        "\n",
        "| dep_one_unrecognized_license_file | Unrecognized license                               |",
        "\n",
        "| dep_two_conflicting_licenses      | License One; Licensir Mock License                 |",
        "\n",
        "| dep_two_licenses                  | License Two, License Three                         |",
        "\n",
        "| dep_two_variants_same_license     | Apache 2.0                                         |",
        "\n",
        "| dep_with_dep                      | Undefined                                          |",
        "\n",
        "|-----------------------------------|----------------------------------------------------|",
        "\n",
        "\n\n"
      ])
      |> to_string()

    assert Licensir.FileAnalyzer.clean(output) == Licensir.FileAnalyzer.clean(expected)
  end

  test "prints csv format when given --csv flag" do
    output =
      capture_io(fn ->
        Mix.Tasks.Licenses.run(["--csv"])
      end)

    expected = """
    Package,Version,License\r
    dep_license_undefined,,Undefined\r
    dep_of_dep,,Undefined\r
    dep_one_license,,Licensir Mock License\r
    dep_one_unrecognized_license_file,,Unrecognized license\r
    dep_two_conflicting_licenses,,"License One; Licensir Mock License"\r
    dep_two_licenses,,"License Two, License Three"\r
    dep_two_variants_same_license,,Apache 2.0\r
    dep_with_dep,,Undefined\r
    """

    assert output == expected
  end
end
