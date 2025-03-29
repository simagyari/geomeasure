defmodule GeoMeasure.Perimeter do
  @moduledoc """
  Calculates the perimeter of a Geo struct.

  ## Examples:

      iex> GeoMeasure.Perimeter.perimeter(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
      8.0

  """

  alias GeoMeasure.Distance

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
  """
  @doc since: "0.0.1"

  @spec perimeter(Geo.Polygon.t()) :: float()
  def perimeter(%Geo.Polygon{coordinates: [coords]}) do
    calculate_perimeter(coords)
  end
end
