# Licensir [![Build Status](https://travis-ci.org/unnawut/licensir.svg?branch=master)](https://travis-ci.org/unnawut/licensir)

An Elixir mix task that list the license(s) of all installed packages in your project.

## Installation

The package can be installed by adding `licensir` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:licensir, "~> 0.2.0", only: :dev, runtime: false}
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
cowboy 2.2.2            -> Undefined
cowlib 2.1.0            -> Undefined
earmark                 -> Apache 2 (see the file LICENSE for details)
ex_doc                  -> Unsure (found: Apache 2.0, Apache 2)
gettext                 -> Apache 2.0
inch_ex                 -> MIT
jason 1.0.0             -> Unsure (found: Apache 2.0, Apache 2)
licensir 0.2.5          -> MIT
mime 1.2.0              -> Apache 2
phoenix_html            -> MIT
phoenix_pubsub 1.0.2    -> MIT
plug 1.5.0              -> Apache 2
poison                  -> CC0-1.0
ranch 1.4.0             -> Undefined
websocket_client        -> Undefined
```

## License

Copyright (c) 2017, Unnawut Leepaisalsuwanna.

Licensir is released under the [MIT License](LICENSE).
