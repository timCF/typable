defmodule Typable.MixProject do
  use Mix.Project

  def project do
    [
      app: :typable,
      version: "VERSION" |> File.read!() |> String.trim(),
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      # excoveralls
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.travis": :test,
        "coveralls.circle": :test,
        "coveralls.semaphore": :test,
        "coveralls.post": :test,
        "coveralls.detail": :test,
        "coveralls.html": :test
      ],
      # dialyxir
      dialyzer: [
        ignore_warnings: ".dialyzer_ignore",
        plt_add_apps: [
          :mix,
          :ex_unit
        ]
      ],
      # ex_doc
      name: "Typable",
      source_url: "https://github.com/timCF/typable",
      homepage_url: "https://github.com/timCF/typable",
      docs: [main: "readme", extras: ["README.md"]],
      # hex.pm stuff
      description: "Protocol which describes type identifier of Elixir term",
      package: [
        licenses: ["Apache 2.0"],
        files: ["lib", "priv", "mix.exs", "README*", "VERSION*"],
        maintainers: ["Ilja Tkachuk AKA timCF"],
        links: %{
          "GitHub" => "https://github.com/timCF/typable",
          "Author's home page" => "https://timcf.github.io"
        }
      ]
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
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      # development tools
      {:excoveralls, "~> 0.8", runtime: false, only: [:dev, :test]},
      {:dialyxir, "~> 0.5", runtime: false, only: [:dev, :test]},
      {:ex_doc, "~> 0.19", runtime: false, only: [:dev, :test]},
      {:credo, "~> 0.9", runtime: false, only: [:dev, :test]},
      {:boilex, "~> 0.2", runtime: false, only: [:dev, :test]}
    ]
  end

  defp aliases do
    [
      docs: ["docs", "cmd mkdir -p doc/priv/img/", "cmd cp -R priv/img/ doc/priv/img/", "docs"]
    ]
  end
end
