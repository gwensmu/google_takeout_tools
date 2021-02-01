defmodule GoogleTakeoutTools.MixProject do
  use Mix.Project

  def project do
    [
      app: :google_takeout_tools,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {GoogleTakeoutTools.Application, []}
    ]
  end

  defp deps do
    [
      csv: "~> 2.4.1",
      dir_walker: "~> 0.0.8"
    ]
  end
end
