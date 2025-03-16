defmodule GeoProperties.Area do
  @moduledoc """
  Calculates the area of Geo struct.
  """

  @spec calculate_area([{number(), number()}]) :: float()
  defp calculate_area(coords) when is_list(coords) do
    coords
    |> Enum.reduce({0, tl(coords)}, fn item, accumulator ->
      {x1, y1} = item
      case accumulator do
        {acc, [{x2, y2} | rest]} ->
          acc = acc + abs(x1 * y2 - x2 * y1)
          {acc, [{x2, y2}] ++ rest}
        {acc, [{_}]} ->
          {acc}
      end
    end)
    |> elem(0)
    |> Kernel./(2)
  end

  @spec area(Geo.Point.t()) :: atom()
  def area(%Geo.Point{}) do
    nil
  end

  @spec area(Geo.LineString.t()) :: atom()
  def area(%Geo.LineString{}) do
    nil
  end

  @spec area(Geo.Polygon.t()) :: float()
  def area(%Geo.Polygon{coordinates: [coords]}) do
    calculate_area(coords)
  end
end
