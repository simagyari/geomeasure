defmodule GeoMeasure.Extent.Test do
  use ExUnit.Case, async: true

  test "calculate_point_extent" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert_raise FunctionClauseError, fn -> GeoMeasure.Extent.calculate(geom) end
  end

  test "calculate_linestring_extent" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert GeoMeasure.Extent.calculate(geom) == {1, 3, 2, 4}
  end

  test "calculate_polygon_extent" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoMeasure.Extent.calculate(geom) == {0, 2, 0, 2}
  end

  test "calculate_linestring_extent_nil_coord" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {nil, 4}]}
    assert_raise ArgumentError, fn -> GeoMeasure.Extent.calculate(geom) end
  end

  test "calculate_polygon_extent_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {nil, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.Extent.calculate(geom) end
  end
end
