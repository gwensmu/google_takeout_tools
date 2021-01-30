# Google Takeout Tools

Currently just a utility to take the massive collection of CSVs that Google sends you when you do Google Takeout on your Google Music (RIP) and turn it into a text summary of your music life.

Presumably its a generic dump of their bigtable or something but, I mean, really, why did they send me 8GB of individual CSV files of one row each, where each row is a song?

On the plus side, a project to practice an Elixir / OTP application.

If I get really ambitious I'll try and programatically create a playlist in Tidal.
## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `google_takeout_tools` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:google_takeout_tools, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/google_takeout_tools](https://hexdocs.pm/google_takeout_tools).

