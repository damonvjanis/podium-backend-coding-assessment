defmodule Podium.MixProject do
  use Mix.Project

  def project do
    [
      app: :podium,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Podium.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.5.1"},
      {:floki, "~> 0.21.0"},
      {:plug_cowboy, "~> 2.0"}
    ]
  end
end
