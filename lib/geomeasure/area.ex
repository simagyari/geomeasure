defmodule GeoMeasure.Area do
  @moduledoc false

  alias GeoMeasure.Utils

  @spec calculate_area([{number(), number()}]) :: float()
  defp calculate_area(coords) when is_list(coords) do
    coords
    |> Enum.reduce({0, tl(coords)}, fn item, accumulator ->
      Utils.tuple_not_nil!(item)
      {x1, y1} = item

      case accumulator do
        {acc, [{x2, y2} | rest]} ->
          Utils.tuple_not_nil!({x2, y2})
          acc = acc + abs(x1 * y2 - x2 * y1)
          {acc, [{x2, y2}] ++ rest}

        {acc, [{_}]} ->
          {acc}
      end
    end)
    |> elem(0)
    |> Kernel./(2)
  end

  @doc """
  Calculates the area of a Geo struct.
  """
  @doc since: "0.0.1"
  @spec calculate(Geo.Polygon.t()) :: float()
  def calculate(%Geo.Polygon{coordinates: [coords]}) do
    calculate_area(coords)
  end
end
