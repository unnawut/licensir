defmodule Licensir.NamingVariants do
  @moduledoc """
  Consolidate different naming variants of the same license to a single name.
  """
  @variants %{
    # Apache 2.0
    "Apache 2" => "Apache 2.0",
    "Apache v2.0" => "Apache 2.0",
    "Apache 2 (see the file LICENSE for details)" => "Apache 2.0"
  }

  @doc """
  Turns all variants of the names into a single one.

  Duplicates are removed if found in the list of variants.
  """
  @spec normalize(String.t() | [String.t()] | nil) :: String.t() | [String.t()] | nil
  def normalize(nil), do: nil

  def normalize(name) when is_binary(name) do
    @variants[name] || name
  end

  def normalize(names), do: names |> Enum.map(&normalize/1) |> Enum.uniq()
end
