defmodule GeoProperties.Bbox do
  @moduledoc"""
  Calculates the bounding box of a Geo struct.
  """

  alias GeoProperties.Extent

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

  @spec bbox(Geo.Point.t()) :: Geo.Point.t()
  def bbox(%Geo.Point{} = point), do: point

  @spec bbox(Geo.LineString.t()) :: Geo.Polygon.t()
  def bbox(%Geo.LineString{coordinates: coords}) do
    calculate_bbox(coords)
  end

  @spec bbox(Geo.Polygon.t()) :: Geo.Polygon.t()
  def bbox(%Geo.Polygon{coordinates: [coords]}) do
    calculate_bbox(coords)
  end
end
