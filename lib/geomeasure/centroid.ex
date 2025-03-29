defmodule GeoMeasure.Centroid do
  @moduledoc false

  alias Geo
  alias GeoMeasure.Utils

  @spec calculate_centroid([{number(), number()}]) :: Geo.Point.t()
  defp calculate_centroid(coords) when is_list(coords) do
    {sum_x, sum_y} =
      Enum.reduce(coords, {0, 0}, fn tpl, acc ->
        Utils.tuple_not_nil!(tpl)
        sum_coordinates(acc, tpl)
      end)

    mean_x = sum_x / length(coords)
    mean_y = sum_y / length(coords)
    %Geo.Point{coordinates: {mean_x, mean_y}}
  end

  @spec sum_coordinates({number(), number()}, {number(), number()}) :: number()
  defp sum_coordinates({lx, ly}, {rx, ry}), do: {lx + rx, ly + ry}

  @doc """
  Calculates the centroid of a Geo struct as a Geo.Point.
  """
  @doc since: "0.0.1"
  @spec calculate(Geo.Point.t()) :: Geo.Point.t()
  def calculate(%Geo.Point{coordinates: coords} = point) do
    Utils.tuple_not_nil!(coords)
    point
  end

  @spec calculate(Geo.LineString.t()) :: Geo.Point.t()
  def calculate(%Geo.LineString{coordinates: coords}) do
    calculate_centroid(coords)
  end

  @spec calculate(Geo.Polygon.t()) :: Get.Point.t()
  def calculate(%Geo.Polygon{coordinates: [coords]}) do
    calculate_centroid(tl(coords))
  end
end
