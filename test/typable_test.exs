defmodule TypableTest do
  use ExUnit.Case
  doctest Typable

  test "greets the world" do
    assert Typable.hello() == :world
  end
end
