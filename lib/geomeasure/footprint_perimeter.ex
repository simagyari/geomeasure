defmodule GeoMeasure.FootprintPerimeter do
  @moduledoc false

  alias GeoMeasure.{Perimeter, Utils}

  @spec calculate(Geo.PolygonZ.t()) :: float
  def calculate(polygonz = %Geo.PolygonZ{}) do
    polygonz
    |> Utils.polygonz_to_polygon()
    |> Perimeter.calculate()
  end
end
