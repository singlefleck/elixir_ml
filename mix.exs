defmodule ElixirMl.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_ml,
      version: "0.1.0",
      elixir: "~> 1.17",
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
      {:axon, "~> 0.8.1"},
      {:nx, "~> 0.13.1"},
      {:explorer, "~> 0.12.0"},
      {:kino, "~> 0.19.0"},
       {:exla, "~> 0.5"},
    {:benchee, github: "bencheeorg/benchee", override: true},
     {:req, "~> 0.5"},
    {:jason, "~> 1.4"}

      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
