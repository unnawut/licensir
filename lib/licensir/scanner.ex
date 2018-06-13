defmodule Licensir.Scanner do
  @moduledoc """
  Scans the project's dependencies for their license information.
  """
  alias Licensir.{License, FileAnalyzer, Guesser}

  @human_names %{
    apache2: "Apache 2",
    bsd: "BSD",
    cc0: "CC0-1.0",
    gpl_v2: "GPLv2",
    gpl_v3: "GPLv3",
    isc: "ISC",
    lgpl: "LGPL",
    mit: "MIT",
    mpl2: "MPL2"
  }

  @doc """
  Scans all dependencies, formats into a list, and print out the result.
  """
  @spec scan() :: list(License.t())
  def scan() do
    # Make sure the dependencies are loaded
    Mix.Project.get!()

    deps()
    |> to_struct()
    |> search_mix()
    |> search_file()
    |> Guesser.guess()
  end

  @spec deps() :: list(Mix.Dep.t())
  defp deps(), do: Mix.Dep.loaded([])

  defp to_struct(deps) when is_list(deps), do: Enum.map(deps, &to_struct/1)

  defp to_struct(%Mix.Dep{} = dep) do
    %License{
      app: dep.app,
      name: Atom.to_string(dep.app),
      version: get_version(dep),
      dep: dep
    }
  end

  defp get_version(%Mix.Dep{status: {:ok, version}}), do: version
  defp get_version(_), do: nil

  defp search_mix(licenses) when is_list(licenses), do: Enum.map(licenses, &search_mix/1)

  defp search_mix(%License{} = license) do
    Map.put(license, :mix, search_mix(license.dep))
  end

  defp search_mix(%Mix.Dep{} = dep) do
    Mix.Dep.in_dependency(dep, fn _ ->
      get_in(Mix.Project.config(), [:package, :licenses])
    end)
  end

  defp search_file(licenses) when is_list(licenses), do: Enum.map(licenses, &search_file/1)

  defp search_file(%License{} = license) do
    Map.put(license, :file, search_file(license.dep))
  end

  defp search_file(%Mix.Dep{} = dep) do
    license_atom =
      Mix.Dep.in_dependency(dep, fn _ ->
        case File.cwd() do
          {:ok, dir_path} -> FileAnalyzer.analyze(dir_path)
          _ -> nil
        end
      end)

    Map.get(@human_names, license_atom)
  end
end
