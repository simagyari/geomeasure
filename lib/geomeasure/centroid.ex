defmodule GeoMeasure.Centroid do
  @moduledoc false

  alias Geo
  alias GeoMeasure.Utils

  @spec calculate_centroid([{number, number}]) :: Geo.Point.t()
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

  @spec calculate_centroid([{number, number, number}]) :: Geo.PointZ.t()
  defp calculate_centroid(coords) when is_list(coords) do
    {sum_x, sum_y, sum_z} =
      Enum.reduce(coords, {0, 0, 0}, fn tpl, acc ->
        Utils.tuple_not_nil!(tpl)
        sum_coordinates(acc, tpl)
      end)

    mean_x = sum_x / length(coords)
    mean_y = sum_y / length(coords)
    mean_z = sum_z / length(coords)
    %Geo.PointZ{coordinates: {mean_x, mean_y, mean_z}}
  end

  @spec sum_coordinates({number, number}, {number, number}) :: {number, number}
  defp sum_coordinates({lx, ly}, {rx, ry}), do: {lx + rx, ly + ry}

  @spec sum_coordinates({number, number, number}, {number, number, number}) :: {number, number, number}
  defp sum_coordinates({lx, ly, lz}, {rx, ry, rz}), do: {lx + rx, ly + ry, lz + rz}

  @doc """
  Calculates the centroid of a Geo struct.
  """
  @doc since: "0.0.1"
  @spec calculate(Geo.Point.t()) :: Geo.Point.t()
  def calculate(%Geo.Point{coordinates: coords} = point) do
    Utils.tuple_not_nil!(coords)
    point
  end

  @spec calculate(Geo.PointM.t()) :: Geo.Point.t()
  def calculate(%Geo.PointM{coordinates: {x, y, _z}}) do
    Utils.tuple_not_nil!({x, y})
    %Geo.Point{coordinates: {x, y}}
  end

  @spec calculate(Geo.PointZ.t()) :: Geo.PointZ.t()
  def calculate(%Geo.PointZ{coordinates: coords}) do
    Utils.tuple_not_nil!(coords)
    %Geo.PointZ{coordinates: coords}
  end

  @spec calculate(Geo.PointZM.t()) :: Geo.PointZ.t()
  def calculate(%Geo.PointZM{coordinates: {x, y, z, _}}) do
    Utils.tuple_not_nil!({x, y, z})
    %Geo.PointZ{coordinates: {x, y, z}}
  end

  @spec calculate(Geo.LineString.t()) :: Geo.Point.t()
  def calculate(%Geo.LineString{coordinates: coords}) do
    calculate_centroid(coords)
  end

  @spec calculate(Geo.LineStringZ.t()) :: Geo.PointZ.t()
  def calculate(%Geo.LineStringZ{coordinates: coords}) do
    calculate_centroid(coords)
  end

  @spec calculate(Geo.LineStringZM.t()) :: Geo.PointZ.t()
  def calculate(%Geo.LineStringZM{coordinates: coords}) do
    trimmed_coords = Enum.map(coords, fn {x, y, z, _} -> {x, y, z} end)
    calculate_centroid(trimmed_coords)
  end

  @spec calculate(Geo.Polygon.t()) :: Get.Point.t()
  def calculate(%Geo.Polygon{coordinates: [coords]}) do
    calculate_centroid(tl(coords))
  end
end
