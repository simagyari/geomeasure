defmodule GeoProperties.Centroid do
  @moduledoc"""
  Calculates the centroid of a Geo struct.
  """

  alias Geo

  defp calculate_centroid(coords) when is_list(coords) do
    xs = Enum.map(coords, fn x -> elem(x, 0) end)
    ys = Enum.map(coords, fn x -> elem(x, 1) end)
    mean_x = Enum.sum(xs) / length(xs)
    mean_y = Enum.sum(ys) / length(ys)
    %Geo.Point{coordinates: {mean_x, mean_y}}
  end

  def centroid(%Geo.Point{} = point), do: point

  def centroid(%Geo.LineString{coordinates: coords}) do
    calculate_centroid(coords)
  end

  def centroid(%Geo.Polygon{coordinates: [coords]}) do
    calculate_centroid(tl(coords))
  end
end
