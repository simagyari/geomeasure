defmodule GeoProperties.Perimeter do
  @moduledoc"""
  Calculates the perimeter of a Geo struct.
  """

  alias GeoProperties.Distance

  @spec calculate_perimeter([{number(), number()}]) :: float()
  defp calculate_perimeter(coords) when is_list(coords) do
    coords
    |> Enum.drop(-1)
    |> Enum.reduce({0, tl(coords)}, fn point_1, {acc, remaining} ->
      case remaining do
        [point_2 = {_a, _b}] ->
          acc = acc + Distance.distance(point_1, point_2)
          IO.puts("Last item")
          IO.inspect(acc)
          {acc, []}
        [point_2 | rest] ->
          acc = acc + Distance.distance(point_1, point_2)
          IO.puts("Not last item")
          IO.inspect(acc)
          {acc, rest}
      end
    end)
    |> elem(0)
  end

  @spec perimeter(Geo.Point.t()) :: atom()
  def perimeter(%Geo.Point{}) do
    nil
  end

  @spec perimeter(Geo.LineString.t()) :: atom()
  def perimeter(%Geo.LineString{}) do
    nil
  end

  @spec perimeter(Geo.Polygon.t()) :: float()
  def perimeter(%Geo.Polygon{coordinates: [coords]}) do
    calculate_perimeter(coords)
  end
end
