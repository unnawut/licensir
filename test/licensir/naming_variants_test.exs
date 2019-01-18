defmodule Licensir.NamingVariantsTest do
  use Licensir.Case
  alias Licensir.NamingVariants

  describe "normalize/1" do
    test "normalizes variants of Apache 2.0" do
      assert NamingVariants.normalize("Apache 2.0") == "Apache 2.0"
      assert NamingVariants.normalize("Apache 2") == "Apache 2.0"
      assert NamingVariants.normalize("Apache v2.0") == "Apache 2.0"
    end

    test "normalizes nil to nil" do
      assert NamingVariants.normalize(nil) == nil
    end

    test "returns the original value if variants are not known" do
      assert NamingVariants.normalize("Unknown License 1.0") == "Unknown License 1.0"
    end

    test "supports a list of licenses" do
      assert NamingVariants.normalize(["Apache 2", nil, "Pass Through"]) == ["Apache 2.0", nil, "Pass Through"]
    end

    test "removes duplicates from the list of licenses" do
      assert NamingVariants.normalize(["One License", "One License"]) == ["One License"]
    end
  end
end
