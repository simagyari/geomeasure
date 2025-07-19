defmodule GeoMeasure.Centroid do
  @moduledoc false

  alias Geo
  alias GeoMeasure.Utils

  @spec calculate_centroid([{number, number}], number | nil) :: Geo.Point.t()
  defp calculate_centroid(coords, srid) do
    {sum_x, sum_y} =
      Enum.reduce(coords, {0, 0}, fn tpl, acc ->
        Utils.tuple_not_nil!(tpl)
        sum_coordinates(acc, tpl)
      end)

    mean_x = sum_x / length(coords)
    mean_y = sum_y / length(coords)
    %Geo.Point{coordinates: {mean_x, mean_y}, srid: srid}
  end

  @spec calculate_centroid_3d([{number, number, number}], number | nil) :: Geo.PointZ.t()
  defp calculate_centroid_3d(coords, srid) do
    {sum_x, sum_y, sum_z} =
      Enum.reduce(coords, {0, 0, 0}, fn tpl, acc ->
        Utils.tuple_not_nil!(tpl)
        sum_coordinates(acc, tpl)
      end)

    mean_x = sum_x / length(coords)
    mean_y = sum_y / length(coords)
    mean_z = sum_z / length(coords)
    %Geo.PointZ{coordinates: {mean_x, mean_y, mean_z}, srid: srid}
  end

  @spec sum_coordinates({number, number}, {number, number}) :: {number, number}
  defp sum_coordinates({lx, ly}, {rx, ry}), do: {lx + rx, ly + ry}

  @spec sum_coordinates({number, number, number}, {number, number, number}) ::
          {number, number, number}
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
  def calculate(%Geo.PointM{coordinates: {x, y, _z}, srid: srid}) do
    Utils.tuple_not_nil!({x, y})
    %Geo.Point{coordinates: {x, y}, srid: srid}
  end

  @spec calculate(Geo.PointZ.t()) :: Geo.PointZ.t()
  def calculate(%Geo.PointZ{coordinates: coords, srid: srid}) do
    Utils.tuple_not_nil!(coords)
    %Geo.PointZ{coordinates: coords, srid: srid}
  end

  @spec calculate(Geo.PointZM.t()) :: Geo.PointZ.t()
  def calculate(%Geo.PointZM{coordinates: {x, y, z, _}, srid: srid}) do
    Utils.tuple_not_nil!({x, y, z})
    %Geo.PointZ{coordinates: {x, y, z}, srid: srid}
  end

  @spec calculate(Geo.LineString.t()) :: Geo.Point.t()
  def calculate(%Geo.LineString{coordinates: coords, srid: srid}) do
    calculate_centroid(coords, srid)
  end

  @spec calculate(Geo.LineStringZ.t()) :: Geo.PointZ.t()
  def calculate(%Geo.LineStringZ{coordinates: coords, srid: srid}) do
    calculate_centroid_3d(coords, srid)
  end

  @spec calculate(Geo.LineStringZM.t()) :: Geo.PointZ.t()
  def calculate(%Geo.LineStringZM{coordinates: coords, srid: srid}) do
    coords
    |> Utils.remove_m_values()
    |> calculate_centroid_3d(srid)
  end

  @spec calculate(Geo.Polygon.t()) :: Geo.Point.t()
  def calculate(%Geo.Polygon{coordinates: coords, srid: srid}) do
    coords
    |> hd()
    |> tl()
    |> calculate_centroid(srid)
  end

  @spec calculate(Geo.PolygonZ.t()) :: Geo.PointZ.t()
  def calculate(%Geo.PolygonZ{coordinates: coords, srid: srid}) do
    coords
    |> hd()
    |> tl()
    |> calculate_centroid_3d(srid)
  end
end
