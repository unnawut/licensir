defmodule DepTwoVariantsSameLicense.MixProject do
  use Mix.Project

  def project do
    [
      app: :dep_two_variants_same_license,
      version: "2.0.0",
      package: package()
    ]
  end

  defp package do
    [
      licenses: ["Apache 2", "Apache v2.0"]
    ]
  end
end
