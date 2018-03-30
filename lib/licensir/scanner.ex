defmodule Licensir.Scanner do
  @moduledoc """
  Scans the project's dependencies for their license information.
  """
  alias Licensir.{License, FileAnalyzer}

  @human_names %{
    apache2: "Apache 2",
    bsd: "BSD",
    cc0: "CC0-1.0",
    gpl_v2: "GPLv2",
    gpl_v3: "GPLv3",
    isc: ["ISC"],
    lgpl: ["LGPL"],
    mit: ["MIT"],
    mpl2: ["MPL2"],
  }

  @doc """
  Scans all dependencies, formats into a list, and print out the result.
  """
  @spec scan() :: list(License.t)
  def scan() do
    Mix.Project.get!() # Make sure the dependencies are loaded

    deps()
    |> to_struct()
    |> search_mix()
    |> search_file()
    |> guess_license()
  end

  @spec deps() :: list(Mix.Dep.t)
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
    Mix.Dep.in_dependency(dep, fn(_) ->
      get_in(Mix.Project.config, [:package, :licenses])
    end)
  end

  defp search_file(licenses) when is_list(licenses), do: Enum.map(licenses, &search_file/1)
  defp search_file(%License{} = license) do
    Map.put(license, :file, search_file(license.dep))
  end
  defp search_file(%Mix.Dep{} = dep) do
    license_atom =
      Mix.Dep.in_dependency(dep, fn(_) ->
        case File.cwd() do
          {:ok, dir_path} -> FileAnalyzer.analyze(dir_path)
          _ -> nil
        end
      end)

    Map.get(@human_names, license_atom)
  end

  defp guess_license(licenses) when is_list(licenses), do: Enum.map(licenses, &guess_license/1)
  defp guess_license(%License{} = license) do
    conclusion = guess_license(license.mix, license.file)
    Map.put(license, :license, conclusion)
  end

  defp guess_license(nil, nil), do: "Undefined"
  defp guess_license(nil, file), do: file
  defp guess_license(mix, nil) when length(mix) > 0, do: Enum.join(mix, ", ")
  defp guess_license(mix, file) when length(mix) == 1 and hd(mix) == file, do: file
  defp guess_license(mix, file) do
    "Unsure (found: " <> Enum.join(mix, ", ") <> ", " <> file <> ")"
  end
end
