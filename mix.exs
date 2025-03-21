defmodule GeoCalc.Mixfile do
  use Mix.Project

  @source_url "https://github.com/simagyari/geocalc"
  @version "0.0.1"

  def project do
    [
      app: :geocalc,
      version: @version,
      elixir: "~> 1.10",
      deps: deps(),
      description: description(),
      package: package(),
      docs: docs(),
      name: "GeoCalc"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    """
    Calculates properties of Geo structs.
    """
  end

  defp deps do
    [
      {:geo, "~> 4.0"}
    ]
  end

  defp package do
    # Files in the package
    [
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Sandor Magyari"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/simagyari/geocalc"}
    ]
  end

  defp docs do
    [
      extras: ["README.md"],
      main: "readme",
      source_url: @source_url,
      formatters: ["html"]
    ]
  end
end
