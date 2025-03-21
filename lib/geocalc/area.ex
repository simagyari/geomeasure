defmodule GeoCalc.Area do
  @moduledoc """
  Calculates the area of Geo struct.

  ## Examples:

      iex> GeoCalc.Area.area(%Geo.Point{coordinates: {1, 2}})
      nil

      iex> GeoCalc.Area.area(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
      nil

      iex> GeoCalc.Area.area(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
      4.0

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

  @doc """
  Calculates the area of a Geo struct.
  """
  @doc since: "0.0.1"
  @spec area(Geo.Point.t()) :: nil
  def area(%Geo.Point{}) do
    nil
  end

  @spec area(Geo.LineString.t()) :: nil
  def area(%Geo.LineString{}) do
    nil
  end

  @spec area(Geo.Polygon.t()) :: float()
  def area(%Geo.Polygon{coordinates: [coords]}) do
    calculate_area(coords)
  end
end
