defmodule GeoMeasure.Distance do
  @moduledoc """
  Calculates distance between two coordinate pairs or Geo.Point structs.

  ## Examples:

      iex> GeoMeasure.Distance.distance({0, 0}, {5, 0})
      5.0

      iex> GeoMeasure.Distance.distance({0, 0}, {3, 4})
      5.0

      iex> GeoMeasure.Distance.distance(%Geo.Point{coordinates: {0, 0}}, %Geo.Point{coordinates: {3, 4}})
      5.0

  """

  alias Geo

  @doc """
  Calculates the distance between two coordinate pairs or Geo.Point structs.
  """
  @doc since: "0.0.1"
  @spec distance({number(), number()}, {number(), number()}) :: float()
  def distance({x1, y1}, {x2, y2}) do
    :math.sqrt(:math.pow(x1 - x2, 2) + :math.pow(y1 - y2, 2))
  end

  @spec distance(Geo.Point.t(), Geo.Point.t()) :: float()
  def distance(%Geo.Point{coordinates: coord_1}, %Geo.Point{coordinates: coord_2}) do
    distance(coord_1, coord_2)
  end
end
