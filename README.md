# Licensir [![Build Status](https://travis-ci.org/unnawut/licensir.svg?branch=master)](https://travis-ci.org/unnawut/licensir) [![Coverage Status](https://coveralls.io/repos/github/unnawut/licensir/badge.svg?branch=master)](https://coveralls.io/github/unnawut/licensir?branch=master)

An Elixir mix task that list the license(s) of all installed packages in your project.

## Installation

The package can be installed by adding `licensir` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:licensir, "~> 0.6", only: :dev, runtime: false}
  ]
end
```

This mix task in most cases only needs to be run on a development machine and independent from the runtime applications, hence the `only: dev, runtime: false` options.

#### Install locally

If you do not wish to include this tool as part of your dependencies, you may also install it locally by running:

```elixir
$ mix archive.install hex licensir 0.6.2
```

Now you can access this tool from any path on your local machine that has access to `mix`.

## Usage

Run `mix licenses` to get the list of packages and their licenses:

```shell
$ mix licenses
Notice: This is not a legal advice. Use the information below at your own risk.
| Package             | License                   | Version | Link                                        |
|---------------------|---------------------------|---------|---------------------------------------------|
| certifi             | BSD                       |         | https://hex.pm/packages/certifi             |
| earmark             | Apache 2.0                | 1.3.2   | https://hex.pm/packages/earmark             |
| ex_doc              | Apache 2.0                | 0.20.2  | https://hex.pm/packages/ex_doc              |
| excoveralls         | MIT                       |         | https://hex.pm/packages/excoveralls         |
| hackney             | Apache 2.0                |         | https://hex.pm/packages/hackney             |
| idna                | BSD; MIT                  |         | https://hex.pm/packages/idna                |
| jason               | Apache 2.0                |         | https://hex.pm/packages/jason               |
| makeup              | BSD; Unrecognized license | 0.8.0   | https://hex.pm/packages/makeup              |
| makeup_elixir       | BSD                       | 0.13.0  | https://hex.pm/packages/makeup_elixir       |
| metrics             | BSD                       |         | https://hex.pm/packages/metrics             |
| mimerl              | MIT                       |         | https://hex.pm/packages/mimerl              |
| nimble_parsec       | Apache 2.0                | 0.5.0   | https://hex.pm/packages/nimble_parsec       |
| ssl_verify_fun      | MIT                       |         | https://hex.pm/packages/ssl_verify_fun      |
| unicode_util_compat | Apache 2.0; BSD           |         | https://hex.pm/packages/unicode_util_compat |
|---------------------|---------------------------|---------|---------------------------------------------|
```

Run `mix licenses --csv` to output in csv format:

```csv
Package,Version,License
certifi,,BSD
earmark,1.3.2,Apache 2.0
ex_doc,0.20.2,Apache 2.0
excoveralls,,"Unsure (found: MIT, Unrecognized license file content)"
hackney,,Apache 2.0
idna,,"Unsure (found: BSD, MIT)"
jason,,Apache 2.0
makeup,0.8.0,"Unsure (found: BSD, Unrecognized license file content)"
makeup_elixir,0.13.0,BSD
metrics,,BSD
mimerl,,MIT
nimble_parsec,0.5.0,Apache 2.0
ssl_verify_fun,,MIT
unicode_util_compat,,"Unsure (found: Apache 2.0, BSD)"
```

### Flags

- `--top-level-only` - Only fetch license information from top level dependencies (e.g. packages that are directly listed in your application's `mix.exs`). Excludes transitive dependencies.

## Usage as a library

You may call the function `Licensir.Scanner.scan()` from your Elixir application to get a list of license data per dependency.

```elixir
iex> Licensir.Scanner.scan([])
[
  %Licensir.License{
    app: :jason,
    dep: %Mix.Dep{
      app: :jason,
      deps: ...
    },
    file: "Apache 2",
    hex_metadata: ["Apache 2.0"],
    license: "Apache 2.0",
    mix: nil,
    name: "jason",
    version: nil
  },
  %Licensir.License{...},
  ...
]
```

## License

Copyright (c) 2017-2019, Unnawut Leepaisalsuwanna.

Licensir is released under the [MIT License](LICENSE).

This project contains 3rd party work as follow:

- ASCII table rendering: a [partial copy](./lib/table_rex) of [djm/table_rex](https://github.com/djm/table_rex).
- CSV rendering: a [partial copy](./lib/csv) of [beatrichartz/csv](https://github.com/beatrichartz/csv).
