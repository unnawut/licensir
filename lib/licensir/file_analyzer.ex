defmodule Licensir.FileAnalyzer do
  # The file names to check for licenses
  @license_files ["LICENSE", "LICENSE.md"]

  # The files that contain the actual text for each license
  @files [
    apache2: ["Apache2_text.txt", "Apache2_url.txt"],
    bsd: ["BSD-3.txt"],
    cc0: ["CC0-1.0.txt"],
    gpl_v2: ["GPLv2.txt"],
    gpl_v3: ["GPLv3.txt"],
    isc: ["ISC.txt"],
    lgpl: ["LGPL.txt"],
    mit: ["MIT.txt"],
    mpl2: ["MPL2.txt"],
  ]

  def analyze(dir_path) do
    Enum.find_value(@license_files, fn(file_name) ->
      dir_path
      |> Path.join(file_name)
      |> File.read()
      |> case do
        {:ok, content} -> analyze_content(content)
        {:error, _} -> nil
      end
    end)
  end

  # Returns the first license that matches
  defp analyze_content(content) do
    Enum.find_value(@files, fn({license, license_files}) ->
      found =
        Enum.find(license_files, fn(license_file) ->
          license =
            :licensir
            |> :code.priv_dir()
            |> Path.join("licenses")
            |> Path.join(license_file)
            |> File.read!()

          # Returns true only if the content is a superset of the license text
          clean(content) =~ clean(license)
        end)

      if found, do: license, else: nil
    end)
  end

  defp clean(content), do: String.replace(content, ~r/\v/, "")
end
