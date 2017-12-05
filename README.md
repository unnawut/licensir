# Licensir

An Elixir mix task that list the license(s) of all installed packages in your project.

## Installation

The package can be installed by adding `licensir` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:licensir, "~> 0.1.0", only: :dev, runtime: false}
  ]
end
```

This mix task in most cases only needs to be run on a development machine and independent from the runtime applications, hence the `only: dev, runtime: false` options.

## Usage

Run the command to get the list of packages and their licenses:

```shell
mix licenses
```

## License

Copyright (c) 2017, Unnawut Leepaisalsuwanna.

Licensir is released under the [MIT License](LICENSE.md).
