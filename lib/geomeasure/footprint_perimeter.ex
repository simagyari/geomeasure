defmodule GeoMeasure.FootprintPerimeter do
  @moduledoc false

  alias GeoMeasure.{Perimeter, Utils}

  @spec calculate(Geo.LineStringZ.t()) :: float
  def calculate(linestringz = %Geo.LineStringZ{}) do
    linestringz
    |> Utils.linestringz_to_linestring()
    |> Perimeter.calculate()
  end

  @spec calculate(Geo.LineStringZM.t()) :: float
  def calculate(linestringzm = %Geo.LineStringZM{}) do
    linestringzm
    |> Utils.linestringzm_to_linestring()
    |> Perimeter.calculate()
  end

  @spec calculate(Geo.MultiLineStringZ.t()) :: float()
  def calculate(%Geo.MultiLineStringZ{coordinates: multi_coords}) do
    Enum.reduce(multi_coords, 0.0, fn coords, acc ->
      acc + calculate(%Geo.LineStringZ{coordinates: coords})
    end)
  end

  @spec calculate(Geo.PolygonZ.t()) :: float
  def calculate(polygonz = %Geo.PolygonZ{}) do
    polygonz
    |> Utils.polygonz_to_polygon()
    |> Perimeter.calculate()
  end

  @spec calculate(Geo.MultiPolygonZ.t()) :: float
  def calculate(%Geo.MultiPolygonZ{coordinates: multi_coords}) do
    Enum.reduce(multi_coords, 0.0, fn coords, acc ->
      acc + calculate(%Geo.PolygonZ{coordinates: coords})
    end)
  end
end
