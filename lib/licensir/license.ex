defmodule Licensir.License do
  @moduledoc """
  Stores license information for a dependency.
  """

  @doc """
  The struct that keeps information about a dependency's license.

  It contains:
    * `app` - the depedency's name as an atom
    * `version` - the version of the dependency being used
    * `license` - the best guess of the license
    * `certainty` - the certainty that the guessed license is correct on a scale of 0.0 to 1.0
    * `license_mix` - the license defined in the dependency's `mix.exs` file
    * `license_file` - the license defined in the dependency's `LICENSE` or `LICENSE.md` file
  """
  defstruct app: nil,
            name: "",
            version: nil,
            dep: nil,
            link: nil,
            license: nil,
            certainty: 0.0,
            mix: nil,
            hex_metadata: nil,
            file: nil

  @type t :: %__MODULE__{
          app: atom(),
          name: String.t(),
          version: String.t() | nil,
          dep: Mix.Dep.t(),
          license: String.t() | nil,
          link: String.t() | nil,
          certainty: float(),
          mix: list(String.t()) | nil,
          hex_metadata: list(String.t()) | nil,
          file: String.t() | nil
        }
end
