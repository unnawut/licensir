defmodule DepTwoLicenses.MixProject do
  use Mix.Project

  def project do
    [
      app: :dep_two_licenses,
      version: "2.0.0",
      package: package()
    ]
  end

  defp package do
    [
      licenses: ["License Two", "License Three"]
    ]
  end
end
