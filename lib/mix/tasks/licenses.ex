defmodule Mix.Tasks.Licenses do
  @moduledoc """
  Lists the licenses defined by each dependecy.

  ## Arguments
      mix licenses      # Prints a list containing the licenses defined in each dependency
  """
  use Mix.Task

  @shortdoc "Lists each dependency's licenses"
  @recursive true

  def run(argv) do
    _ = Mix.Shell.IO.info([:yellow, "Notice: This is not a legal advice. Use the information below at your own risk."])

    {opts, _argv} = OptionParser.parse!(argv, switches: [
      top_level_only: :boolean
    ])

    Licensir.Scanner.scan(opts)
    |> Enum.sort_by(fn license -> license.name end)
    |> Enum.map(&to_row/1)
    |> TableRex.quick_render!(["Package", "Version", "License"])
    |> IO.puts()
  end

  defp to_row(map) do
    [map.name, map.version, map.license]
  end
end
