defmodule ElixirMlTest do
  use ExUnit.Case
  doctest ElixirMl

  test "greets the world" do
    assert ElixirMl.hello() == :world
  end
end
