defmodule ExBrotli.MixProject do
  use Mix.Project
  @version "0.2.0"

  def project do
    [
      app: :ex_brotli,
      version: @version,
      elixir: "~> 1.13",
      description: "Elixir wrapper for Rust based brotli compression",
      start_permanent: Mix.env() == :prod,
      docs: [
        extras: ["README.md"],
        main: "readme"
      ],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def package do
    [
      licenses: ["MIT"],
      maintainers: ["Martin Feckie"],
      links: %{
        "Github" => "https://github.com/mfeckie/ex_brotli"
      },
      files: ["lib", "native", "README.md", "mix.exs", "checksum-*.exs"],
      exclude_patterns: [
        "native/ex_brotli/target"
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler_precompiled, "~> 0.6"},
      {:rustler, "~> 0.29", optional: true},
      {:phoenix, ">= 0.0.0"},
      {:ex_doc, "0.29.4"}
    ]
  end
end
