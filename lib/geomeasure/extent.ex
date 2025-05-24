defmodule GeoMeasure.Extent do
  @moduledoc false

  alias GeoMeasure.Utils

  @spec calculate_extent([{number, number}]) :: {number, number, number, number}
  def calculate_extent(coords) do
    coords
    |> Enum.reduce({nil, nil, nil, nil}, fn {x, y}, {min_x, max_x, min_y, max_y} ->
      Utils.tuple_not_nil!({x, y})

      {
        min_x |> min_or_init(x),
        max_x |> max_or_init(x),
        min_y |> min_or_init(y),
        max_y |> max_or_init(y)
      }
    end)
  end

  @spec calculate_extent_3d([{number, number, number}]) :: {number, number, number, number, number, number}
  def calculate_extent_3d(coords) do
    coords
    |> Enum.reduce({nil, nil, nil, nil, nil, nil}, fn {x, y, z}, {min_x, max_x, min_y, max_y, min_z, max_z} ->
      Utils.tuple_not_nil!({x, y, z})

      {
        min_x |> min_or_init(x),
        max_x |> max_or_init(x),
        min_y |> min_or_init(y),
        max_y |> max_or_init(y),
        min_z |> min_or_init(z),
        max_z |> max_or_init(z)
      }
    end)
  end

  @spec min_or_init(nil, number) :: number | nil
  defp min_or_init(nil, val), do: val

  @spec min_or_init(number, number) :: number
  defp min_or_init(current, val), do: min(current, val)

  @spec max_or_init(nil, number) :: number | nil
  defp max_or_init(nil, val), do: val

  @spec max_or_init(number, number) :: number
  defp max_or_init(current, val), do: max(current, val)

  @doc """
  Calculates the extent coordinates of a Geo struct.
  """
  @doc since: "0.0.1"
  @spec calculate(Geo.LineString.t()) :: {number, number, number, number}
  def calculate(%Geo.LineString{coordinates: coords}) do
    calculate_extent(coords)
  end

  @spec calculate(Geo.LineStringZ.t()) :: {number, number, number, number, number, number}
  def calculate(%Geo.LineStringZ{coordinates: coords}) do
    calculate_extent_3d(coords)
  end

  @spec calculate(Geo.LineStringZM.t()) :: {number, number, number, number, number, number}
  def calculate(%Geo.LineStringZM{coordinates: coords}) do
    coords
    |> Utils.remove_m_values()
    |> calculate_extent_3d()
  end

  @spec calculate(Geo.Polygon.t()) :: {number, number, number, number}
  def calculate(%Geo.Polygon{coordinates: [coords]}) do
    calculate_extent(tl(coords))
  end
end
