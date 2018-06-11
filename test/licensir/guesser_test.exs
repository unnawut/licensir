defmodule Licensir.GuesserTest do
  use Licensir.Case
  alias Licensir.{Guesser, License}

  describe "Guesser.guess/1" do
    test "returns the license in mix" do
      license = %License{
        mix: ["License in Mix"],
        file: nil
      }

      assert Guesser.guess(license).license == "License in Mix"
    end

    test "returns the license in file" do
      license = %License{
        mix: nil,
        file: "License in file"
      }

      assert Guesser.guess(license).license == "License in file"
    end

    test "returns the license if the license in mix and file are equal" do
      license = %License{
        mix: ["Same License"],
        file: "Same License"
      }

      assert Guesser.guess(license).license == "Same License"
    end

    test "returns unsure if the license in mix and file are not the same" do
      license = %License{
        mix: ["License One"],
        file: "License Two"
      }

      assert Guesser.guess(license).license == "Unsure (found: License One, License Two)"
    end

    test "returns unsure if there are multiple licenses in mix and also one definted in file" do
      license = %License{
        mix: ["License One", "License Two"],
        file: "License Three"
      }

      assert Guesser.guess(license).license ==
               "Unsure (found: License One, License Two, License Three)"
    end

    test "returns Undefined if no license data is found" do
      license = %License{
        mix: nil,
        file: nil
      }

      assert Guesser.guess(license).license == "Undefined"
    end
  end
end
