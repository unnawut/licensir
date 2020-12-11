defmodule LicensirCSV do
  use CSV.Defaults

  alias CSV.Encoding.Encoder

  @moduledoc ~S"""
  RFC 4180 compliant CSV parsing and encoding for Elixir. Allows to specify
  other separators, so it could also be named: TSV, but it isn't.
  """

  @doc """
  Encode a table stream into a stream of RFC 4180 compliant CSV lines for
  writing to a file or other IO.

  ## Options

  These are the options:

    * `:separator`   – The separator token to use, defaults to `?,`.
    Must be a codepoint (syntax: ? + (your separator)).
    * `:delimiter`   – The delimiter token to use, defaults to `\\r\\n`.
    Must be a string.

  ## Examples

  Convert a stream of rows with cells into a stream of lines:

      iex> [~w(a b), ~w(c d)]
      iex> |> CSV.encode
      iex> |> Enum.take(2)
      [\"a,b\\r\\n\", \"c,d\\r\\n\"]

  Convert a stream of rows with cells with escape sequences into a stream of
  lines:

      iex> [[\"a\\nb\", \"\\tc\"], [\"de\", \"\\tf\\\"\"]]
      iex> |> CSV.encode(separator: ?\\t, delimiter: \"\\n\")
      iex> |> Enum.take(2)
      [\"\\\"a\\\\nb\\\"\\t\\\"\\\\tc\\\"\\n\", \"de\\t\\\"\\\\tf\\\"\\\"\\\"\\n\"]
  """

  def encode(stream, options \\ []) do
    Encoder.encode(stream, options)
  end
end
