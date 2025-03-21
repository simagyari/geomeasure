defmodule GeoMeasure.Perimeter.Test do
  use ExUnit.Case, async: true

  test "calculate_point_perimeter" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert GeoMeasure.Perimeter.perimeter(geom) == nil
  end

  test "calculate_linestring_perimeter" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert GeoMeasure.Perimeter.perimeter(geom) == nil
  end

  test "calculate_polygon_perimeter" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoMeasure.Perimeter.perimeter(geom) == 8.0
  end
end
