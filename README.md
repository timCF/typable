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
    {:typable, "~> 0.3.0"}
  ]
end
```

## Examples

```elixir
iex> require Type
Type

iex> Type.type_of(1)
Integer
iex> Type.type_of(self())
PID
iex> Type.type_of(%URI{})
URI

iex> Type.instance_of(Integer)
0
iex> Type.instance_of(PID)
#PID<0.0.0>
iex> Type.instance_of(URI)
%URI{
  authority: nil,
  fragment: nil,
  host: nil,
  path: nil,
  port: nil,
  query: nil,
  scheme: nil,
  userinfo: nil
}
```
