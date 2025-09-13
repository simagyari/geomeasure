defmodule GeoMeasure.Perimeter do
  @moduledoc false

  alias GeoMeasure.{Distance, Utils}

  @spec calculate_perimeter([{number, number}] | [{number, number, number}]) :: float
  defp calculate_perimeter(coords) do
    coords
    |> Enum.reduce({0, tl(coords)}, fn point_1, {acc, remaining} ->
      case remaining do
        [] ->
          acc

        [point_2] when is_tuple(point_2) ->
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

  @spec calculate(Geo.LineString.t()) :: float
  def calculate(%Geo.LineString{coordinates: coords}) do
    calculate_perimeter(coords)
  end

  @spec calculate(Geo.LineStringM.t()) :: float
  def calculate(%Geo.LineStringM{coordinates: coords}) do
    coords
    |> Utils.remove_m_values()
    |> calculate_perimeter()
  end

  @spec calculate(Geo.LineStringZ.t()) :: float
  def calculate(%Geo.LineStringZ{coordinates: coords}) do
    calculate_perimeter(coords)
  end

  @spec calculate(Geo.LineStringZM.t()) :: float
  def calculate(%Geo.LineStringZM{coordinates: coords}) do
    coords
    |> Utils.remove_m_values()
    |> calculate_perimeter()
  end

  @spec calculate(Geo.Polygon.t()) :: float
  def calculate(%Geo.Polygon{coordinates: [ring]}) do
    calculate_perimeter(ring)
  end

  @spec calculate(Geo.Polygon.t()) :: float
  def calculate(%Geo.Polygon{coordinates: [_first, _second | _rest] = coords}) do
    Enum.reduce(coords, 0, fn coord_list, acc -> acc + calculate_perimeter(coord_list) end)
  end

  @spec calculate(Geo.PolygonZ.t()) :: float
  def calculate(%Geo.PolygonZ{coordinates: [ring]}) do
    calculate_perimeter(ring)
  end

  @spec calculate(Geo.PolygonZ.t()) :: float
  def calculate(%Geo.PolygonZ{coordinates: [_first, _second | _rest] = coords}) do
    Enum.reduce(coords, 0, fn coord_list, acc -> acc + calculate_perimeter(coord_list) end)
  end
end
