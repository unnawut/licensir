defmodule Licensir.Licenses do
  @extra_name_padding 4

  @doc """
  Extracts licenses from the dependencies, formats into a list, and print out the result.
  """
  def list() do
    Mix.Project.get!

    IO.puts("Licenses listed by their dependency:")

    get_deps()
    |> deps_to_named_map()
    |> map_license()
    |> print_formatted()
  end

  defp get_deps() do
    Mix.Dep.loaded([])
  end

  defp deps_to_named_map(deps) do
    Enum.map(deps, fn(%Mix.Dep{app: _, status: _} = dep) ->
      {format_name(dep), dep}
    end)
    |> Map.new
  end

  defp format_name(%Mix.Dep{app: app, status: status}) do
    case status do
      {:ok, vsn} when vsn != nil -> "#{app} #{vsn}"
      _ -> "#{app}"
    end
  end

  defp map_license(deps) when is_map(deps) do
    Enum.map(deps, &map_license/1)
  end
  defp map_license({app, %Mix.Dep{} = dep}) do
    licenses = Mix.Dep.in_dependency(dep, fn _ ->
      get_in(Mix.Project.config, [:package, :licenses])
    end)

    {app, licenses}
  end

  defp print_formatted(dep_licenses) when is_list(dep_licenses) do
    max_length = max_dep_name_length(dep_licenses)
    Enum.each(dep_licenses, fn({dep_name, licenses}) ->
      print_formatted(dep_name, licenses, max_length)
    end)
  end
  defp print_formatted(dep_name, licenses, max_name_length) do
    IO.puts(format_dep_name(dep_name, max_name_length) <> "-> " <> format_licenses(licenses))
  end

  defp max_dep_name_length(dep_licenses) do
    dep_licenses
    |> Enum.max_by(fn({dep_name, _}) -> String.length(dep_name) end)
    |> Kernel.elem(0)
    |> String.length
    |> Kernel.+(@extra_name_padding)
  end

  defp format_dep_name(name, max_pad_trailing) do
    String.pad_trailing(name, max_pad_trailing)
  end

  defp format_licenses([head | tail]) do
    Enum.reduce(tail, head, fn(license, concatenated) ->
      concatenated <> ", " <> license
    end)
  end

  defp format_licenses(nil) do
    "License is undefined"
  end
end
