defmodule GeoProperties.Extent do
  @moduledoc"""
  Calculates the extent of a Geo struct and returns it as a Geo.Polygon.
  """

  def calculate_extent(coords) when is_list(coords) do
    coords
    |> Enum.reduce({nil, nil, nil, nil}, fn {x, y}, {min_x, max_x, min_y, max_y} ->
      {
        min_x |> min_or_init(x),
        max_x |> max_or_init(x),
        min_y |> min_or_init(y),
        max_y |> max_or_init(y)
      }
    end)
  end

  defp min_or_init(nil, val), do: val

  defp min_or_init(current, val), do: min(current, val)

  defp max_or_init(nil, val), do: val

  defp max_or_init(current, val), do: max(current, val)

  def extent(%Geo.Point{}) do
    nil
  end

  def extent(%Geo.LineString{coordinates: coords}) do
    calculate_extent(coords)
  end

  def extent(%Geo.Polygon{coordinates: [coords]}) do
    calculate_extent(tl(coords))
  end
end
