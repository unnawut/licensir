defmodule Licensir.FileAnalyzer do
  # The file names to check for licenses
  @license_files ["LICENSE", "LICENSE.md", "LICENSE.txt", "LICENCE"]

  # The files that contain the actual text for each license
  @files [
    agpl_v3: ["AGPLv3.txt"],
    apache2: [
      "Apache2_text.txt",
      "Apache2_text.variant-2.txt",
      "Apache2_text.variant-3.txt",
      "Apache2_url.txt"
    ],
    bsd: ["BSD-3.txt", "BSD-3.variant-2.txt"],
    cc0: ["CC0-1.0.txt"],
    gpl_v2: ["GPLv2.txt"],
    gpl_v3: ["GPLv3.txt"],
    isc: ["ISC.txt", "ISC.variant-2.txt"],
    lgpl: ["LGPL.txt"],
    mit: ["MIT.txt", "MIT.variant-2.txt", "MIT.variant-3.txt"],
    mpl2: ["MPL2.txt", "MPL2b.txt"],
    licensir_mock_license: ["LicensirMockLicense.txt"]
  ]

  def analyze(dir_path) do
    # IO.inspect(analyze_dir: dir_path)
    Enum.find_value(@license_files, fn file_name ->
      dir_path
      |> Path.join(file_name)
      |> File.read()
      |> case do
        {:ok, content} ->
          # IO.inspect(analyze: file_name)
          analyze_content(content)
          #|> IO.inspect
        {:error, _} -> nil
      end
    end)
  end

  # Returns the first license that matches
  defp analyze_content(content) do
    content = clean(content)
    # IO.inspect(content: content)

    Enum.find_value(@files, fn {license, license_files} ->
      found =
        Enum.find(license_files, fn license_file ->
          license_text =
            :licensir
            |> :code.priv_dir()
            |> Path.join("licenses")
            |> Path.join(license_file)
            |> File.read!()
            |> clean()

          # IO.inspect(license: license)
          # IO.inspect(license_file: license_file)

          # Returns true only if the content is a superset of the license text
          content =~ license_text
        end)

      # IO.inspect(found: found)

      if found, do: license, else: nil
    end) || unrecognised(content)
  end

  defp unrecognised(_content) do
    # IO.inspect(unrecognised_license: content)
    :unrecognized_license_file
  end

  def clean(content),
    do:
      content
      |> String.replace("\n", " ")
      |> String.replace(~r/\s\s+/, " ")
      |> String.trim()
      |> String.downcase()
end
