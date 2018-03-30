defmodule Licensir.Mixfile do
  use Mix.Project

  def project do
    [
      app: :licensir,
      version: "0.2.6",
      elixir: "~> 1.5",
      escript: [main_module: Licensir.Licenses],
      deps: deps(),
      name: "Licensir",
      description: "An Elixir mix task that list the license(s) of all installed packages in your project.",
      package: package()
    ]
  end

  defp package do
    [
      files: ["lib", "priv", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Unnawut Leepaisalsuwanna"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/unnawut/licensir"},
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
