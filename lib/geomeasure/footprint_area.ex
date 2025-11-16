defmodule GeoMeasure.FootprintArea do
  @moduledoc false

  alias GeoMeasure.{Area, Utils}

  @spec calculate(Geo.PolygonZ.t()) :: float
  def calculate(polygonz = %Geo.PolygonZ{}) do
    polygonz
    |> Utils.polygonz_to_polygon()
    |> Area.calculate()
  end

  @spec calculate(Geo.MultiPolygonZ.t()) :: float
  def calculate(%Geo.MultiPolygonZ{coordinates: multi_coords}) do
    Enum.reduce(multi_coords, 0.0, fn polygon_coords, acc ->
      acc + calculate(%Geo.PolygonZ{coordinates: polygon_coords})
    end)
  end
end
