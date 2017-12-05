defmodule Mix.Tasks.Licenses do
  use Mix.Task

  @shortdoc "Lists the licenses defined by each dependecy"

  @moduledoc """
  Lists the licenses defined by each dependecy.

  ## Arguments
      mix licenses      # Prints a list containing the licenses defined in each dependency
  """

  @recursive true

  def run(_argv) do
    Licensir.Licenses.list
  end
end
