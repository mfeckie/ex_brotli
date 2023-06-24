defmodule ExBrotli.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_brotli,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler_precompiled, "0.6.1"},
      {:rustler, "0.29.0"},
      {:ex_doc, "0.29.4"}
    ]
  end
end
