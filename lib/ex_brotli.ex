defmodule ExBrotli do
  mix_config = Mix.Project.config()
  version = mix_config[:version]

  @moduledoc """
  Wrapper functions for interacting with the Rust based brotli library
  """

  use RustlerPrecompiled,
    otp_app: :ex_brotli,
    crate: :ex_brotli,
    base_url: "https://github.com/mfeckie/ex_brotli/releases/download/#{version}",
    force_build: System.get_env("FORCE_COMPILE") in ["1", "true"],
    version: version

  @doc """
  Compress a binary using brotli

  ## Examples

      iex> ExBrotli.compress("hello")
      {:ok,  <<11, 2, 128, 104, 101, 108, 108, 111, 3>>}
  """
  def compress(_binary), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Decompress a binary using brotli

  ## Examples

      iex> ExBrotli.decompress(<<11, 2, 128, 104, 101, 108, 108, 111, 3>>)
      {:ok, "hello"}
  """
  def decompress(_binary), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Compress a binary using brotli, raising an error if the compression fails

  see `compress/1` for examples
  """
  def compress!(binary) do
    case compress(binary) do
      {:ok, result} -> result
      {:error, reason} -> raise reason
    end
  end

  @doc """
  Decompress a binary using brotli, raising an error if the decompression fails

  see `decompress/1` for examples
  """
  def decompress!(binary) do
    case decompress(binary) do
      {:ok, result} -> result
      {:error, reason} -> raise reason
    end
  end
end
