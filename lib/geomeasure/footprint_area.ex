defmodule GeoMeasure.FootprintArea do
  @moduledoc false

  alias GeoMeasure.{Area, Utils}

  @spec calculate(Geo.PolygonZ.t()) :: float
  def calculate(polygonz = %Geo.PolygonZ{}) do
    polygonz
    |> Utils.polygonz_to_polygon()
    |> Area.calculate()
  end
end
