defmodule GeoMeasure.Centroid.Test do
  use ExUnit.Case, async: true

  test "calculate_point_centroid" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert GeoMeasure.Centroid.centroid(geom) == %Geo.Point{coordinates: {1, 2}}
  end

  test "calculate_linestring_centroid" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert GeoMeasure.Centroid.centroid(geom) == %Geo.Point{coordinates: {2.0, 3.0}}
  end

  test "calculate_polygon_centroid" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoMeasure.Centroid.centroid(geom) == %Geo.Point{coordinates: {1.0, 1.0}}
  end
end
