defmodule JsonXema.MixProject do
  use Mix.Project

  def project do
    [
      app: :json_xema,
      version: "0.2.1",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      aliases: aliases(),
      elixirc_paths: elixirc_paths(Mix.env()),
      test_coverage: [tool: ExCoveralls],
      source_url: "https://github.com/hrzndhrn/json_xema",
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      docs: [
        extras: [
          "docs/readme.md",
          "docs/usage.md",
          "docs/loader.md",
          "docs/unsupported.md"
        ]
      ],
      dialyzer: [
        ignore_warnings: "dialyzer.ignore-warnings"
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description() do
    "A JSON Schema validator for draft-04, -06, and -07."
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:benchee, "~> 1.0", only: :dev},
      {:benchee_markdown, "~> 0.2", only: :dev},
      {:conv_case, "~> 0.2"},
      {:cowboy, "~> 2.2", only: :test},
      {:credo, "~> 1.0", only: [:dev, :test]},
      {:dialyxir, "~> 1.0.0-rc.4", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:ex_json_schema, "~> 0.5"},
      {:excoveralls, "~> 0.8", only: :test},
      {:httpoison, "~> 1.0", only: :test},
      {:inch_ex, "~> 2.0.0-rc1", only: [:dev, :test]},
      {:jason, "~> 1.0", only: [:dev, :test]},
      {:xema, "~> 0.9"}
    ]
  end

  defp package do
    [
      maintainers: ["Marcus Kruse"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/hrzndhrn/json_xema"},
      files: [
        "lib",
        "mix.exs",
        "README*",
        "LICENSE*",
        "docs/readme.md",
        "docs/usage.md",
        "docs/loader.md",
        "docs/unsupported.md"
      ]
    ]
  end

  defp aliases do
    [bench: ["run bench/run.exs"]]
  end
end
