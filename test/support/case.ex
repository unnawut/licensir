defmodule Licensir.Case do
  defmacro __using__(_) do
    quote do
      use ExUnit.Case

      setup do
        Mix.Project.push(Licensir.TestApp)
        on_exit(fn -> Mix.Project.pop() end)
      end
    end
  end
end
