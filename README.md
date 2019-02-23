# Typable

Protocol which describes type identifier of Elixir term

[![Hex](https://raw.githubusercontent.com/tim2CF/static-asserts/master/build-passing.svg?sanitize=true)](https://hex.pm/packages/typable/)
[![Documentation](https://raw.githubusercontent.com/tim2CF/static-asserts/master/documentation-passing.svg?sanitize=true)](https://hexdocs.pm/typable/)

<img src="priv/img/logo.png" width="300"/>

## Installation

The package can be installed by adding `typable` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:typable, "~> 0.1.0"}
  ]
end
```

## Examples

```elixir
iex> Typable.type_of(1)
Integer
iex> Typable.type_of(self())
PID
iex> Typable.type_of(%URI{})
URI
```
