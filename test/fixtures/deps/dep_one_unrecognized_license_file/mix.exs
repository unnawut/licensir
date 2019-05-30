defmodule DepOneUnrecognizedLicense.MixProject do
  use Mix.Project

  def project do
    [
      app: :dep_one_license,
      version: "1.0.0",
      package: package()
    ]
  end

  defp package do
    [
      licenses: []
    ]
  end
end
