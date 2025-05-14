defmodule GeoMeasure.Distance do
  @moduledoc false

  alias Geo
  alias GeoMeasure.Utils

  @doc """
  Calculates the distance between two coordinate pairs or Geo.Point structs.
  """
  @doc since: "0.0.1"
  @spec calculate({number, number}, {number, number}) :: float
  def calculate({x1, y1}, {x2, y2}) do
    Utils.tuple_not_nil!({x1, y1})
    Utils.tuple_not_nil!({x2, y2})
    :math.sqrt(:math.pow(x1 - x2, 2) + :math.pow(y1 - y2, 2))
  end

  @spec calculate({number, number, number}, {number, number, number}) :: float
  def calculate({x1, y1, z1}, {x2, y2, z2}) do
    Utils.tuple_not_nil!({x1, y1, z1})
    Utils.tuple_not_nil!({x2, y2, z2})
    :math.sqrt(:math.pow(x2 - x1, 2) + :math.pow(y2 - y1, 2) + :math.pow(z2 - z1, 2))
  end

  @spec calculate(Geo.Point.t(), Geo.Point.t()) :: float
  def calculate(%Geo.Point{coordinates: coord_1}, %Geo.Point{coordinates: coord_2}) do
    calculate(coord_1, coord_2)
  end

  @spec calculate(Geo.PointM.t(), Geo.PointM.t()) :: float
  def calculate(%Geo.PointM{coordinates: {x1, y1, _m1}}, %Geo.PointM{coordinates: {x2, y2, _m2}}) do
    calculate({x1, y1}, {x2, y2})
  end

  @spec calculate(Geo.Point.t(), Geo.PointM.t()) :: float
  def calculate(%Geo.Point{coordinates: coord1}, %Geo.PointM{coordinates: {x2, y2, _m2}}) do
    calculate(coord1, {x2, y2})
  end

  @spec calculate(Geo.PointM.t(), Geo.Point.t()) :: float
  def calculate(%Geo.PointM{coordinates: {x1, y1, _m1}}, %Geo.Point{coordinates: coord2}) do
    calculate({x1, y1}, coord2)
  end

  @spec calculate(Geo.PointZ.t(), Geo.PointZ.t()) :: float
  def calculate(%Geo.PointZ{coordinates: coord1}, %Geo.PointZ{coordinates: coord2}) do
    calculate(coord1, coord2)
  end

  @spec calculate(Geo.PointZM.t(), Geo.PointZM.t()) :: float
  def calculate(%Geo.PointZM{coordinates: {x1, y1, z1, _m1}}, %Geo.PointZM{
        coordinates: {x2, y2, z2, _m2}
      }) do
    calculate({x1, y1, z1}, {x2, y2, z2})
  end

  @spec calculate(Geo.PointZ.t(), Geo.PointZM.t()) :: float
  def calculate(%Geo.PointZ{coordinates: coord1}, %Geo.PointZM{coordinates: {x2, y2, z2, _m2}}) do
    calculate(coord1, {x2, y2, z2})
  end

  @spec calculate(Geo.PointZM.t(), Geo.PointZ.t()) :: float
  def calculate(%Geo.PointZM{coordinates: {x1, y1, z1, _m1}}, %Geo.PointZ{coordinates: coord2}) do
    calculate({x1, y1, z1}, coord2)
  end
end
