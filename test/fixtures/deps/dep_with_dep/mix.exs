defmodule DepWithDep.MixProject do
  use Mix.Project

  def project do
    [
      app: :dep_with_dep,
      version: "0.0.1",
      package: package(),
      deps: deps()
    ]
  end

  defp package do
    [
    ]
  end

  defp deps do
    [
      {:dep_of_dep, path: "../dep_of_dep"}
    ]
  end
end
