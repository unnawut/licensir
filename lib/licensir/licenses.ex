defmodule Licensir.Licenses do
  def list do
    IO.puts("Listing licenses...")

    Mix.Project.get!

    []
    |> Mix.Dep.loaded()
    |> Enum.map(fn %Mix.Dep{app: _, status: _} = dep ->
      Mix.Dep.in_dependency dep, fn _ ->
        IO.write(get_in(Mix.Project.config, [:app]))
        IO.write(": ")
        case get_in(Mix.Project.config, [:package, :licenses]) do
          licenses when is_list(licenses) ->
            [head | tail] = licenses
            IO.write head
            Enum.each(tail, fn(license) ->
              IO.write ", " <> license
            end)
          _ -> IO.write("license undefined")
        end
        IO.puts ""
      end
    end)
  end
end
