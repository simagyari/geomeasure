defmodule GeoMeasure.Mixfile do
  use Mix.Project

  @source_url "https://github.com/simagyari/geomeasure"
  @version "1.7.0"

  def project do
    [
      app: :geomeasure,
      version: @version,
      elixir: "~> 1.10",
      deps: deps(),
      description: description(),
      package: package(),
      docs: docs(),
      name: "GeoMeasure"
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
      {:geo, "~> 4.1"},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false}
    ]
  end

  defp package do
    # Files in the package
    [
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Sandor Istvan Magyari"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/simagyari/geomeasure"}
    ]
  end

  defp docs do
    [
      extras: ["README.md", "CHANGELOG.md", "LICENSE"],
      main: "readme",
      source_url: @source_url,
      source_ref: "main",
      formatters: ["html"]
    ]
  end
end
