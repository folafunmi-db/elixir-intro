defmodule WordCountMixTest do
  use ExUnit.Case
  doctest WordCountMix

  test "greets the world" do
    assert WordCountMix.hello() == :world
  end
end
