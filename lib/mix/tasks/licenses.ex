defmodule Mix.Tasks.Licenses do
  @moduledoc """
  Lists the licenses defined by each dependecy.

  Notice: The output from this tool is not a legal advice. Use the information at your own risk.

  ## Arguments
      mix licenses      # Prints a list containing the licenses defined in each dependency
  """
  use Mix.Task

  @shortdoc "Lists each dependency's licenses"
  @recursive true
  @switches [
    top_level_only: :boolean,
    csv: :boolean
  ]

  def run(argv) do
    {opts, _argv} = OptionParser.parse!(argv, switches: @switches)

    Licensir.Scanner.scan(opts)
    |> Enum.sort_by(fn license -> license.name end)
    |> Enum.map(&to_row/1)
    |> render(opts)
  end

  defp to_row(map) do
    [map.name, map.version, map.license]
  end

  defp render(rows, opts) do
    cond do
      Keyword.get(opts, :csv) -> render_csv(rows)
      true -> render_ascii_table(rows)
    end
  end

  defp render_ascii_table(rows) do
    _ = Mix.Shell.IO.info([:yellow, "Notice: This is not a legal advice. Use the information below at your own risk."])

    rows
    |> TableRex.quick_render!(["Package", "Version", "License"])
    |> IO.puts()
  end

  defp render_csv(rows) do
    rows
    |> List.insert_at(0, ["Package", "Version", "License"])
    |> Licensir.CSV.encode()
    |> Enum.each(&IO.write/1)
  end
end
