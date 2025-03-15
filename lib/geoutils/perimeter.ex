defmodule GeoProperties.Perimeter do
  @moduledoc"""
  Calculates the perimeter of a Geo struct.
  """

  alias Distance

  defp calculate_perimeter(coords) when is_list(coords) do
    coords
    |> Enum.reduce({0, tl(coords)}, fn item, accumulator ->
      {x1, y1} = point_1
      case accumulator do
        {acc, [point_2 | rest]} ->
          acc = acc + Distance.distance(point_1, point_2)
          {acc, [point_2] ++ rest}
        {acc, [point_2 = {_a, _b}]} ->
          acc = acc + Distance.distance(point_1, point_2)
          {acc}
      end
    end)
    elem(0)
  end

  def perimeter(%Geo.Point{}) do
    nil
  end

  def perimeter(%Geo.LineString{}) do
    nil
  end

  def perimeter(%Get.Polygon{coordinates: [coords]}) do
    calculate_perimeter(coords)
  end
end
