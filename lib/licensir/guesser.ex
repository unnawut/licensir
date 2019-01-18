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
    mix_licenses = NamingVariants.normalize(license.mix)
    file_licenses = NamingVariants.normalize(license.file)

    conclusion = guess(mix_licenses, file_licenses)
    Map.put(license, :license, conclusion)
  end

  defp guess(nil, nil), do: "Undefined"
  defp guess(nil, file), do: file
  defp guess(mix, nil) when length(mix) > 0, do: Enum.join(mix, ", ")
  defp guess(mix, file) when length(mix) == 1 and hd(mix) == file, do: file

  defp guess(mix, file) do
    "Unsure (found: " <> Enum.join(mix, ", ") <> ", " <> file <> ")"
  end
end
