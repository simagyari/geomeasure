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

  @spec calculate(Geo.PolygonZ.t()) :: float
  def calculate(polygonz = %Geo.PolygonZ{}) do
    polygonz
    |> Utils.polygonz_to_polygon()
    |> Perimeter.calculate()
  end
end
