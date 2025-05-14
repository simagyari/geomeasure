defmodule GeoMeasure.Perimeter do
  @moduledoc false

  alias GeoMeasure.{Distance, Utils}

  @spec calculate_perimeter([{number(), number()}]) :: float()
  defp calculate_perimeter(coords) when is_list(coords) do
    coords
    |> Enum.reduce({0, tl(coords)}, fn point_1, {acc, remaining} ->
      IO.inspect({point_1, remaining, acc})
      case remaining do
        [] ->
          acc

        [point_2 = {_a, _b}] ->
          acc = acc + Distance.calculate(point_1, point_2)
          {acc, []}

        [point_2 | rest] ->
          acc = acc + Distance.calculate(point_1, point_2)
          {acc, rest}
      end
    end)
  end

  @doc """
  Calculates the perimeter of a Geo struct.
  """
  @doc since: "0.0.1"

  @spec calculate(Geo.LineString.t()) :: float()
  def calculate(%Geo.LineString{coordinates: coords}) do
    calculate_perimeter(coords)
  end

  @spec calculate(Geo.LineStringZ.t()) :: float()
  def calculate(%Geo.LineStringZ{coordinates: coords}) do
    calculate_perimeter(coords)
  end

  @spec calculate(Geo.LineStringZM.t()) :: float()
  def calculate(%Geo.LineStringZM{coordinates: coords}) do
    coords
    |> Utils.remove_m_values()
    |> calculate_perimeter()
  end

  @spec calculate(Geo.Polygon.t()) :: float()
  def calculate(%Geo.Polygon{coordinates: [coords]}) do
    calculate_perimeter(coords)
  end
end
