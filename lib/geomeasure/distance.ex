defmodule GeoMeasure.Distance do
  @moduledoc false

  alias Geo
  alias GeoMeasure.Utils

  @doc """
  Calculates the distance between two coordinate pairs or Geo.Point structs.
  """
  @doc since: "0.0.1"
  @spec calculate({number(), number()}, {number(), number()}) :: float()
  def calculate({x1, y1}, {x2, y2}) do
    Utils.tuple_not_nil!({x1, y1})
    Utils.tuple_not_nil!({x2, y2})
    :math.sqrt(:math.pow(x1 - x2, 2) + :math.pow(y1 - y2, 2))
  end

  @spec calculate(Geo.Point.t(), Geo.Point.t()) :: float()
  def calculate(%Geo.Point{coordinates: coord_1}, %Geo.Point{coordinates: coord_2}) do
    calculate(coord_1, coord_2)
  end

  @spec calculate(Geo.PointM.t(), Geo.PointM.t()) :: float()
  def calculate(%Geo.PointM{coordinates: {x1, y1}}, %Geo.PointM{coordinates: {x2, y2}}) do
    calculate({x1, y1}, {x2, y2})
  end

  @spec calculate(Geo.Point.t(), Geo.PointM.t()) :: float()
  def calculate(%Geo.Point{coordinates: coord1}, %Geo.PointM{coordinates: {x2, y2}}) do
    calculate(coord1, {x2, y2})
  end

  @spec calculate(Geo.PointM.t(), Geo.Point.t()) :: float()
  def calculate(%Geo.PointM{coordinates: {x1, y1}}, %Geo.Point{coordinates: coord2}) do
    calculate({x1, y1}, coord2)
  end
end
