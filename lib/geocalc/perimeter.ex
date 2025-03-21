defmodule GeoCalc.Perimeter do
  @moduledoc"""
  Calculates the perimeter of a Geo struct.
  """

  alias GeoCalc.Distance

  @spec calculate_perimeter([{number(), number()}]) :: float()
  defp calculate_perimeter(coords) when is_list(coords) do
    coords
    |> Enum.drop(-1)
    |> Enum.reduce({0, tl(coords)}, fn point_1, {acc, remaining} ->
      case remaining do
        [point_2 = {_a, _b}] ->
          acc = acc + Distance.distance(point_1, point_2)
          {acc, []}
        [point_2 | rest] ->
          acc = acc + Distance.distance(point_1, point_2)
          {acc, rest}
      end
    end)
    |> elem(0)
  end

  @doc """
  Calculates the perimeter of a Geo struct.

  ## Examples:

    iex> GeoCalc.Perimeter.perimeter(%Geo.Point{coordinates: {1, 2}})
    nil

    iex> GeoCalc.Perimeter.perimeter(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
    nil

    iex> GeoCalc.Perimeter.perimeter(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
    8.0

  """
  @doc since: "0.0.1"
  @spec perimeter(Geo.Point.t()) :: nil
  def perimeter(%Geo.Point{}) do
    nil
  end

  @spec perimeter(Geo.LineString.t()) :: nil
  def perimeter(%Geo.LineString{}) do
    nil
  end

  @spec perimeter(Geo.Polygon.t()) :: float()
  def perimeter(%Geo.Polygon{coordinates: [coords]}) do
    calculate_perimeter(coords)
  end
end
