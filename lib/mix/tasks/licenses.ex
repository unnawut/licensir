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
    |> Enum.sort_by(fn(license) -> license.name end)
    |> print_licenses()
  end

  defp print_licenses(licenses) do
    Enum.each(licenses, fn(license) ->
      license.name <> " " <> (license.version || "")
      |> String.pad_trailing(@name_width)
      |> Kernel.<>("-> " <> license.license)
      |> IO.puts()
    end)
  end
end
