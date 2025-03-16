defmodule GeoProperties.Area.Test do
  use ExUnit.Case, async: true

  test "calculate_point_area" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert GeoProperties.Area.area(geom) == nil
  end

  test "calculate_linestring_area" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert GeoProperties.Area.area(geom) == nil
  end

  test "calculate_polygon_area" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoProperties.Area.area(geom) == 4.0
  end
end
