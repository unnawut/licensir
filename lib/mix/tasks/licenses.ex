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
    csv: :boolean,
    only_license: :boolean
  ]

  def run(argv) do
    {opts, _argv} = OptionParser.parse!(argv, switches: @switches)

    Licensir.Scanner.scan(opts)
    |> Enum.sort_by(fn lib -> lib.name end)
    |> Enum.map(&to_row(&1, opts))
    |> render(opts)
  end

  defp to_row(map, opts) do
    if Keyword.get(opts, :only_license),
      do: [map.name, map.license],
      else: [map.name, map.license, map.version, map.link]
  end

  defp render(rows, opts) do
    if Keyword.get(opts, :only_license),
      do: render(rows, opts, ["Package", "License"]),
      else: render(rows, opts, ["Package", "License", "Version", "Link"])
  end

  defp render(rows, opts, headers) do
    cond do
      Keyword.get(opts, :csv) ->
        render_csv(rows, headers)

      true ->
        render_ascii_table(rows, headers)
    end
  end

  defp render_ascii_table(rows, headers) do
    _ =
      Mix.Shell.IO.info([
        :yellow,
        "Notice: This is not a legal advice. Use the information below at your own risk."
      ])

    rows
    |> TableRex.quick_render!(headers)
    |> file_touch()
    |> output()
  end

  defp render_csv(rows, headers) do
    rows
    |> List.insert_at(0, headers)
    |> Licensir.CSV.encode()
    |> file_touch()
    |> Enum.each(&output/1)
  end

  defp file_touch(text) do
    if @output_file do
      with {:ok, file} <- File.open(@output_file, [:write]) do
        # IO.puts("\n\nSaving the output to " <> @output_file)
        IO.binwrite(file, "\n")
        text
      else
        e ->
          _ =
            Mix.Shell.IO.info([
              :yellow,
              "WARNING: Could not write to " <> @output_file
            ])

          nil
      end
    end
  end

  defp output(text) do
    filewriter = fn filename, data ->
      File.open(filename, [:append])
      |> elem(1)
      |> IO.binwrite(data)
    end

    if @output_file, do: filewriter.(@output_file, text)
  end
end
