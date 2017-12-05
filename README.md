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

The command above should return an output similar to below (example from [phoenix](https://github.com/phoenixframework/phoenix)):

```shell
$ mix licenses
Licenses listed by their dependency:
cowboy 1.1.2            -> License is undefined
cowlib 1.0.2            -> License is undefined
earmark                 -> Apache 2 (see the file LICENSE for details)
ex_doc                  -> Apache 2.0
gettext                 -> Apache 2.0
inch_ex                 -> MIT
mime 1.1.0              -> Apache 2
phoenix_html            -> MIT
phoenix_pubsub 1.0.2    -> MIT
plug 1.4.3              -> Apache 2
poison 3.1.0            -> CC0-1.0
ranch 1.3.2             -> License is undefined
websocket_client        -> License is undefined
```

## License

Copyright (c) 2017, Unnawut Leepaisalsuwanna.

Licensir is released under the [MIT License](LICENSE.md).
