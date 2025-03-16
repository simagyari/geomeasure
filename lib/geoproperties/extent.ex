defmodule GeoProperties.Extent do
  @moduledoc"""
  Calculates the extent of a Geo struct and returns it as a Geo.Polygon.
  """

  @spec calculate_extent([{number(), number()}]) :: {number(), number(), number(), number()}
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

  @spec min_or_init(atom(), number()) :: atom() | number()
  defp min_or_init(nil, val), do: val

  @spec min_or_init(number(), number()) :: number()
  defp min_or_init(current, val), do: min(current, val)

  @spec max_or_init(atom(), number()) :: atom() | number()
  defp max_or_init(nil, val), do: val

  @spec max_or_init(number(), number()) :: number()
  defp max_or_init(current, val), do: max(current, val)

  @spec extent(Geo.Point.t()) :: atom()
  def extent(%Geo.Point{}) do
    nil
  end

  @spec extent(Geo.LineString.t()) :: atom()
  def extent(%Geo.LineString{coordinates: coords}) do
    calculate_extent(coords)
  end

  @spec extent(Geo.Polygon.t()) :: {number(), number(), number(), number()}
  def extent(%Geo.Polygon{coordinates: [coords]}) do
    calculate_extent(tl(coords))
  end
end
