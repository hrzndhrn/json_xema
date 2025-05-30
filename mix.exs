defmodule JsonXema.MixProject do
  use Mix.Project

  def project do
    [
      app: :json_xema,
      version: "0.6.5",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      aliases: aliases(),
      elixirc_paths: elixirc_paths(Mix.env()),
      test_coverage: [tool: ExCoveralls],
      source_url: "https://github.com/hrzndhrn/json_xema",
      preferred_cli_env: [
        carp: :test,
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.github": :test,
        "coveralls.html": :test,
        "gen.test_suite": :test
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
        plt_file: {:no_warn, "test/support/plts/dialyzer.plt"}
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
      {:xema, "~> 0.16"},
      # dev and test
      {:benchee, "~> 1.1", only: :dev},
      {:benchee_markdown, "~> 0.2", only: :dev},
      {:conv_case, "~> 0.2"},
      {:cowboy, "~> 2.12", only: :test},
      {:credo, "~> 1.6", only: [:dev, :test]},
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.28", only: :dev, runtime: false},
      {:ex_json_schema, "~> 0.9", only: :dev},
      {:excoveralls, "~> 0.14", only: :test},
      {:httpoison, "~> 2.2", only: :test},
      {:jason, "~> 1.3", only: [:dev, :test]},
      {:recode, "~> 0.7", only: [:dev]}
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
        "docs/unsupported.md",
        "CHANGELOG.md"
      ]
    ]
  end

  defp aliases do
    [
      bench: ["run bench/run.exs"],
      carp: "test --seed 0 --max-failures 1 --trace"
    ]
  end
end
