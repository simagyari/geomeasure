defmodule GeoProperties.Extent do
  @moduledoc"""
  Calculates the extent of a Geo struct.
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

  @spec min_or_init(nil, number()) :: number() | nil
  defp min_or_init(nil, val), do: val

  @spec min_or_init(number(), number()) :: number()
  defp min_or_init(current, val), do: min(current, val)

  @spec max_or_init(nil, number()) :: number() | nil
  defp max_or_init(nil, val), do: val

  @spec max_or_init(number(), number()) :: number()
  defp max_or_init(current, val), do: max(current, val)

  @doc """
  Calculates the extent coordinates of a Geo struct.

  ## Examples:

    iex> GeoProperties.Extent.extent(%Geo.Point{coordinates: {1, 2}})
    nil

    iex> GeoProperties.Extent.extent(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
    {1, 3, 2, 4}

    iex> GeoProperties.Extent.extent(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
    {0, 2, 0, 2}

  """
  @doc since: "0.0.1"
  @spec extent(Geo.Point.t()) :: nil
  def extent(%Geo.Point{}) do
    nil
  end

  @spec extent(Geo.LineString.t()) :: {number(), number(), number(), number()}
  def extent(%Geo.LineString{coordinates: coords}) do
    calculate_extent(coords)
  end

  @spec extent(Geo.Polygon.t()) :: {number(), number(), number(), number()}
  def extent(%Geo.Polygon{coordinates: [coords]}) do
    calculate_extent(tl(coords))
  end
end
