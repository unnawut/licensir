defmodule Licensir.ConfigFile do
  @moduledoc """
  Parse a project's .licensir.exs file to determine what licenses are acceptable to the user, not acceptable, and projects that are allowed
  """

  @config_filename ".licensir.exs"

  defstruct allowlist: [], denylist: [], allow_deps: []

  def parse(nil), do: parse(@config_filename)
  def parse(file) do
    if File.exists?(file) do
      {:ok, raw} =
        file
        |> File.read!()
        |> Credo.ExsLoader.parse()

      {:ok,
       %__MODULE__{
         allowlist: raw[:allowlist] || [],
         denylist: raw[:denylist] || [],
         allow_deps: Enum.map(raw[:allow_deps] || [], &Atom.to_string/1)
       }}
    else
      {:ok, %__MODULE__{}}
    end
  end
end
