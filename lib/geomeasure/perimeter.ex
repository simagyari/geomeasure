defmodule GeoMeasure.Perimeter do
  @moduledoc false

  alias GeoMeasure.Distance

  @spec calculate_perimeter([{number(), number()}]) :: float()
  defp calculate_perimeter(coords) when is_list(coords) do
    coords
    |> Enum.drop(-1)
    |> Enum.reduce({0, tl(coords)}, fn point_1, {acc, remaining} ->
      case remaining do
        [point_2 = {_a, _b}] ->
          acc = acc + Distance.calculate(point_1, point_2)
          {acc, []}

        [point_2 | rest] ->
          acc = acc + Distance.calculate(point_1, point_2)
          {acc, rest}
      end
    end)
    |> elem(0)
  end

  @doc """
  Calculates the perimeter of a Geo struct.
  """
  @doc since: "0.0.1"
  @spec calculate(Geo.Polygon.t()) :: float()
  def calculate(%Geo.Polygon{coordinates: [coords]}) do
    calculate_perimeter(coords)
  end
end
