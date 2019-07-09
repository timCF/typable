defmodule TypableTest do
  use ExUnit.Case
  require Type
  doctest Type
  doctest Typable

  [
    # scalars
    Atom,
    BitString,
    Float,
    Function,
    Integer,
    PID,
    Port,
    Reference,
    # collections
    Tuple,
    List,
    Map
  ]
  |> Enum.each(fn type ->
    test "type_of/instance_of inversability for #{type}" do
      assert unquote(type) == unquote(type) |> Type.instance_of() |> Type.type_of()
    end
  end)
end
