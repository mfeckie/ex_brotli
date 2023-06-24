defmodule ExBrotli do
  mix_config = Mix.Project.config()
  version = mix_config[:version]

  use RustlerPrecompiled,
    otp_app: :ex_brotli,
    crate: :exbrotli,
    base_url: "https://github.com/mfeckie/ex_brotli/releases/download/#{version}",
    force_build: System.get_env("RUSTLER_PRECOMPILATION_EXAMPLE_BUILD") in ["1", "true"],
    targets: ~w(
      aarch64-apple-darwin
      aarch64-unknown-linux-gnu
      aarch64-unknown-linux-musl
      riscv64gc-unknown-linux-gnu
      x86_64-apple-darwin
      x86_64-pc-windows-msvc
      x86_64-pc-windows-gnu
      x86_64-unknown-linux-gnu
      x86_64-unknown-linux-musl
    ),
    version: version

  def compress(_binary), do: :erlang.nif_error(:nif_not_loaded)

  def compress!(binary) do
    case compress(binary) do
      {:ok, result} -> result
      {:error, reason} -> raise reason
    end
  end
end
