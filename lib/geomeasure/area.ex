defmodule GeoMeasure.Area do
  @moduledoc false

  alias GeoMeasure.Utils

  @spec calculate_area([{number, number}]) :: float
  defp calculate_area(coords) do
    coords
    |> Enum.reduce({0, tl(coords)}, fn item, accumulator ->
      Utils.tuple_not_nil!(item)
      {x1, y1} = item

      case accumulator do
        {acc, [{x2, y2} | rest]} ->
          Utils.tuple_not_nil!({x2, y2})
          acc = acc + x1 * y2 - x2 * y1
          {acc, rest}

        {acc, []} ->
          acc
      end
    end)
    |> abs()
    |> Kernel./(2)
  end

  @doc """
  Calculates the area of a Geo struct.
  """
  @doc since: "0.0.1"
  @spec calculate(Geo.Polygon.t()) :: float
  def calculate(%Geo.Polygon{coordinates: [outer_ring]}) do
    calculate_area(outer_ring)
  end

  @spec calculate(Geo.Polygon.t()) :: float
  def calculate(%Geo.Polygon{coordinates: [outer_ring, inner_ring | rest]}) do
    outer_area = calculate_area(outer_ring)

    inner_area =
      Enum.reduce([inner_ring] ++ rest, 0, fn coord_list, acc ->
        acc + calculate_area(coord_list)
      end)

    outer_area - inner_area
  end
end
