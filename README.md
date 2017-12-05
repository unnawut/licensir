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
Listing licenses...
websocket_client: license undefined
gettext: Apache 2.0
ranch: license undefined
poison: CC0-1.0
licensir: MIT
earmark: Apache 2 (see the file LICENSE for details)
ex_doc: Apache 2.0
phoenix_pubsub: MIT
cowlib: license undefined
cowboy: license undefined
mime: Apache 2
plug: Apache 2
phoenix_html: MIT
inch_ex: MIT
```

## License

Copyright (c) 2017, Unnawut Leepaisalsuwanna.

Licensir is released under the [MIT License](LICENSE.md).
