defmodule Licensir.Case do
  use ExUnit.CaseTemplate
  alias Licensir.TestApp
  alias Mix.Project

  setup do
    Project.push(TestApp)
    on_exit(fn -> Project.pop() end)
  end
end
