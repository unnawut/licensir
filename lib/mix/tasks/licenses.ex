defmodule Mix.Tasks.Licenses do
  @moduledoc """
  Lists the licenses defined by each dependecy.

  ## Arguments
      mix licenses      # Prints a list containing the licenses defined in each dependency
  """
  use Mix.Task

  @shortdoc "Lists each dependency's licenses"
  @recursive true

  @name_width 24

  def run(_argv) do
    Licensir.Scanner.scan()
    |> Enum.sort_by(fn license -> license.name end)
    |> Enum.map(&print_license/1)
    |> Mix.Shell.IO.info()
  end

  defp print_license(%{name: name, version: version, license: license}) do
    [
      String.pad_trailing(name <> " " <> (version || ""), @name_width),
      "-> ",
      color(license),
      :reset,
      "\n"
    ]
  end

  defp color("Unsure " <> _ = license), do: [:yellow, license]
  defp color("Undefined" = license), do: [:red, license]
  defp color(license), do: [:green, license]
end
