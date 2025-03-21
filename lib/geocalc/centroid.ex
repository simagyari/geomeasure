defmodule GeoCalc.Centroid do
  @moduledoc"""
  Calculates the centroid of a Geo struct.

  ## Examples:

      iex> GeoCalc.Centroid.centroid(%Geo.Point{coordinates: {1, 2}})
      %Geo.Point{coordinates: {1, 2}}

      iex> GeoCalc.Centroid.centroid(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
      %Geo.Point{coordinates: {2.0, 3.0}}

      iex> GeoCalc.Centroid.centroid(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
      %Geo.Point{coordinates: {1.0, 1.0}}

  """

  alias Geo

  @spec calculate_centroid([{number(), number()}]) :: Geo.Point.t()
  defp calculate_centroid(coords) when is_list(coords) do
    xs = Enum.map(coords, fn x -> elem(x, 0) end)
    ys = Enum.map(coords, fn x -> elem(x, 1) end)
    mean_x = Enum.sum(xs) / length(xs)
    mean_y = Enum.sum(ys) / length(ys)
    %Geo.Point{coordinates: {mean_x, mean_y}}
  end

  @doc """
  Calculates the centroid of a Geo struct as a Geo.Point.
  """
  @doc since: "0.0.1"
  @spec centroid(Geo.Point.t()) :: Geo.Point.t()
  def centroid(%Geo.Point{} = point), do: point

  @spec centroid(Geo.LineString.t()) :: Geo.Point.t()
  def centroid(%Geo.LineString{coordinates: coords}) do
    calculate_centroid(coords)
  end

  @spec centroid(Geo.Polygon.t()) :: Get.Point.t()
  def centroid(%Geo.Polygon{coordinates: [coords]}) do
    calculate_centroid(tl(coords))
  end
end
