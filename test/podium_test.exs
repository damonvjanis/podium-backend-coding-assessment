defmodule PodiumTest do
  use ExUnit.Case
  doctest Podium

  test "greets the world" do
    assert Podium.hello() == :world
  end
end
