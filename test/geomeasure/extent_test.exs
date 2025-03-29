defmodule GeoMeasure.Extent.Test do
  use ExUnit.Case, async: true

  test "calculate_point_extent" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert_raise FunctionClauseError, fn -> GeoMeasure.Extent.extent(geom) end
  end

  test "calculate_linestring_extent" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert GeoMeasure.Extent.extent(geom) == {1, 3, 2, 4}
  end

  test "calculate_polygon_extent" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoMeasure.Extent.extent(geom) == {0, 2, 0, 2}
  end
end
