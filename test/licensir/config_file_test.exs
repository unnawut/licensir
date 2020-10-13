defmodule Licensir.ConfigFileTest do
  use Licensir.Case
  alias Licensir.{ConfigFile}

  describe "parse" do
    test "returns options" do
      assert {:ok, config} = ConfigFile.parse("test/fixtures/licensir-config.exs")
      assert config.allowlist == ["MIT", "Apache 2.0"]
      assert config.denylist == ["GPLv2", "Licensir Mock License"]
      assert config.allow_deps == ["dep_mock_license"]
    end
  end
end
