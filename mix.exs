defmodule Licensir.Mixfile do
  use Mix.Project

  def project do
    [
      app: :licensir,
      version: "0.4.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      escript: [main_module: Licensir.Licenses],
      deps: deps(),
      name: "Licensir",
      description:
        "An Elixir mix task that list the license(s) of all installed packages in your project.",
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["test/support", "lib"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      files: ["lib", "priv", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Unnawut Leepaisalsuwanna"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/unnawut/licensir"}
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:excoveralls, "~> 0.8", only: :test}
    ]
  end
end
