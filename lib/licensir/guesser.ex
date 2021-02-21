defmodule Licensir.Guesser do
  @moduledoc """
  A module that determines a dependency's license based on different sources gathered.
  """
  alias Licensir.{License, NamingVariants}

  @doc """
  Guess the license based on the available license data.
  """
  def guess(licenses) when is_list(licenses), do: Enum.map(licenses, &guess/1)

  def guess(%License{} = license) do
    hex_metadata_licenses = NamingVariants.normalize(license.hex_metadata)
    file_licenses = NamingVariants.normalize(license.file)

    conclusion = guess(hex_metadata_licenses, file_licenses)
    Map.put(license, :license, conclusion)
  end

  defp guess(file, ""), do: guess(file, nil)
  defp guess(nil, nil), do: "Undefined"
  defp guess(nil, file), do: file
  defp guess(hex, nil) when length(hex) > 0, do: Enum.join(hex, "; ")
  defp guess(hex, file) when length(hex) == 1 and hd(hex) == file, do: file

  defp guess(hex, file) do
    Enum.join(hex, "; ") <> "; " <> file
  end
end
