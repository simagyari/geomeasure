defmodule GeoProperties.Bbox do
  @moduledoc"""
  Calculates the bounding box of a Geo struct.
  """

  alias GeoProperties.Extent

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

  def bbox(%Geo.Point{} = point), do: point

  def bbox(%Geo.LineString{coordinates: coords}) do
    calculate_bbox(coords)
  end

  def bbox(%Geo.Polygon{coordinates: [coords]}) do
    calculate_bbox(coords)
  end
end
