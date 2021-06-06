defmodule Licensir.Mixfile do
  use Mix.Project

  @source_url "https://github.com/unnawut/licensir"
  @version "0.6.2"

  def project do
    [
      app: :licensir,
      version: @version,
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      escript: [main_module: Licensir.Licenses],
      name: "Licensir",
      deps: deps(),
      package: package(),
      docs: docs(),
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
      description:
        "An Elixir mix task that list the license(s) " <>
          "of all installed packages in your project.",
      files: ["lib", "priv", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Unnawut Leepaisalsuwanna"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:excoveralls, "~> 0.8", only: :test}
    ]
  end

  defp docs do
    [
      extras: [
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      formatters: ["html"],
      filter_prefix: "Licensir"
    ]
  end
end
