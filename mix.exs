defmodule Gmail.Mixfile do
  use Mix.Project

  def project do
    [app: :gmail,
     version: "0.0.10",
     elixir: "~> 1.0",
     deps: deps,
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test],
     description: "A simple Gmail REST API client for Elixir, mostly built as a learning exercise",
     package: package]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.7.3"},
      {:poison, "~> 1.5.0"},
      {:timex, "~> 0.19.3"},
      {:mock, "~> 0.1.1", only: :test},
      {:excoveralls, "0.4.2", only: :test},
      {:earmark, "0.1.17", only: :dev},
      {:ex_doc, "0.11.2", only: :dev},
      {:dialyxir, "~> 0.3", only: :dev}
    ]
  end

  defp package do
    [
      # files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
      files: ["lib", "mix.exs", "README*"],
      licenses: ["MIT"],
      maintainers: ["Craig Paterson"],
      links: %{"Github" => "https://github.com/craigp/elixir-gmail"}]
  end

end
