defmodule Mix.Tasks.Licenses do
  use Mix.Task

  @shortdoc "List license(s) of each dependecy"
  @moduledoc @shortdoc

  @recursive true

  def run(_argv) do
    Licensir.Licenses.list
  end
end
