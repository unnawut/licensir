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
    [:yellow, "Licenses listed by their dependency:"] |> IO.ANSI.format() |> IO.puts()

    licenses = Licensir.Scanner.scan()

    Enum.each(licenses, fn(license) ->
      license.name <> " " <> (license.version || "")
      |> String.pad_trailing(@name_width)
      |> Kernel.<>("-> " <> license.license)
      |> IO.puts()
    end)
  end
end
