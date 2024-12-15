defmodule GeoUtils.Area do
  @moduledoc """
  Calculates area of Geo struct.
  """

  # TODO: revamp it to collect x and y values separately, then add the last vertex, then do the same as now -> look up shoelace method
  defp calculate_area(coords) when is_list(coords) do

    last_coord = List.last(coords)
    coords_nolast = Enum.drop(coords, -1)
    coords_nolast
    |> Enum.reduce({0, coords_nolast}, fn {x1, y1}, {acc, [{x2, y2} | rest]} ->
      acc = acc + (x1 * y2 - x2 * y1)
      IO.inspect(acc)
      IO.inspect({x1, y1, x2, y2, rest})

      {acc, [{x2, y2}] ++ rest}
    end)
    |> elem(0)
    |>
    |> abs()
    |> Kernel./(2)
  end

  def area(%Geo.Point{}) do
    0.0
  end

  def area(%Geo.LineString{}) do
    0.0
  end

  def area(%Geo.Polygon{coordinates: coords}) do
    IO.inspect(coords)
    coord = List.first(coords)
    calculate_area(coord)
  end
end
