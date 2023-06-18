defmodule PerceptronSimpleTest do
  use ExUnit.Case
  doctest PerceptronSimple

  test "greets the world" do
    assert PerceptronSimple.hello() == :world
  end
end
