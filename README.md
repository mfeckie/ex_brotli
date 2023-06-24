# ExBrotli

Wrapper around [rust-brotli](https://github.com/dropbox/rust-brotli)

## Installation

```elixir
def deps do
  [
    {:ex_brotli, "~> 0.1.0"}
  ]
end
```

# Direct usage

`ExBrotli.compress/1` takes a binary and compresses using Brotli, returns `{:ok, compressed_binary} | {:error, reason}`
`ExBrotli.compress!/1` takes a binary and compresses using Brotli.  Raise on error.

# Phoenix Asset Compression

Add configuration to `Plug.Static`.

```elixir
plug Plug.Static,
 ...
 brotli: true
 ```
 
Then tell Phoenix to also compress with Brotli.

```elixir
# Compression for asset pipeline
config :phoenix,
  static_compressors: [
    Phoenix.Digester.Gzip,
    ExBrotli.DigesterCompressor
  ]
```