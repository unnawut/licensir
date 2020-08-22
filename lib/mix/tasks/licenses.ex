defmodule Mix.Tasks.Licenses do
  @moduledoc """
  Lists the licenses defined by each dependecy.

  Notice: The output from this tool is not a legal advice. Use the information at your own risk.

  ## Arguments
      mix licenses      # Prints a list containing the licenses defined in each dependency
  """
  use Mix.Task

  @output_file "DEPENDENCIES.md"
  @shortdoc "Lists each dependency's licenses"
  @recursive true
  @switches [
    top_level_only: :boolean,
    csv: :boolean
  ]

  def run(argv) do
    {opts, _argv} = OptionParser.parse!(argv, switches: @switches)

    Licensir.Scanner.scan(opts)
    |> Enum.sort_by(fn lib -> lib.name end)
    |> Enum.map(&to_row/1)
    |> render(opts)
  end

  defp to_row(map) do
    [map.name, map.license, map.version, map.link]
  end

  defp render(rows, opts) do
    cond do
      Keyword.get(opts, :csv) -> render_csv(rows)
      true -> render_ascii_table(rows)
    end
  end

  defp render_ascii_table(rows) do
    _ =
      Mix.Shell.IO.info([
        :yellow,
        "Notice: This is not a legal advice. Use the information below at your own risk."
      ])

    rows
    |> TableRex.quick_render!(["Package", "License", "Version", "Link"])
    |> output()
  end

  defp render_csv(rows) do
    rows
    |> List.insert_at(0, ["Package", "Version", "License"])
    |> CSV.encode()
    |> Enum.each(&output/1)
  end

  defp output(text) do
    IO.write(text)

    if @output_file do
      with {:ok, file} <- File.open(@output_file, [:write]) do
        IO.binwrite(file, text)
        IO.puts("\n\nSaved the output to " <> @output_file)
      else
        e ->
          IO.puts("\n\nCould not write to " <> @output_file)
      end
    end
  end
end
