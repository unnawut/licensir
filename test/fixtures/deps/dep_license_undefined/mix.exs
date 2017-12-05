defmodule DepLicenseUndefined.MixProject do
  use Mix.Project

  def project do
    [
      app: :dep_license_undefined,
      version: "1.0.0",
      package: package()
    ]
  end

  defp package do
    [
      # Undefined license
    ]
  end
end
