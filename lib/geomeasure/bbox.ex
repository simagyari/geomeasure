defmodule GeoMeasure.Bbox do
  @moduledoc false

  alias GeoMeasure.{Extent, Utils}

  @spec calculate_bbox([{number(), number()}]) :: Geo.Polygon.t()
  defp calculate_bbox(coords) when is_list(coords) do
    {min_x, max_x, min_y, max_y} = Extent.calculate_extent(coords)

    %Geo.Polygon{
      coordinates: [
        [
          {min_x, min_y},
          {min_x, max_y},
          {max_x, max_y},
          {max_x, min_y},
          {min_x, min_y}
        ]
      ]
    }
  end

  @doc """
  Calculates the bounding box of a Geo struct as a Geo.Polygon.
  """
  @doc since: "0.0.1"
  @spec calculate(Geo.Point.t()) :: Geo.Point.t()
  def calculate(%Geo.Point{coordinates: coords} = point) do
    Utils.tuple_not_nil!(coords)
    point
  end

  @spec calculate(Geo.LineString.t()) :: Geo.Polygon.t()
  def calculate(%Geo.LineString{coordinates: coords}) do
    calculate_bbox(coords)
  end

  @spec calculate(Geo.Polygon.t()) :: Geo.Polygon.t()
  def calculate(%Geo.Polygon{coordinates: [coords]}) do
    calculate_bbox(coords)
  end
end
