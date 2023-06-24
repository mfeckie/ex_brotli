defmodule ExBrotliTest do
  use ExUnit.Case
  doctest ExBrotli

  test "Compresses a binary" do
    assert ExBrotli.compress("hello") == {:ok, <<11, 2, 128, 104, 101, 108, 108, 111, 3>>}
  end

  test "Matches sample compressed file" do
    input = File.read!("test/10x10y")
    output = File.read!("test/10x10y.br")

    assert ExBrotli.compress(input) == {:ok, output}
  end

  test "Compress!" do
    assert ExBrotli.compress!("hello") == <<11, 2, 128, 104, 101, 108, 108, 111, 3>>
  end
end
