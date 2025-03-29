defmodule GeoMeasure.Perimeter.Test do
  use ExUnit.Case, async: true

  test "calculate_point_perimeter" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert_raise FunctionClauseError, fn -> GeoMeasure.Perimeter.calculate(geom) end
  end

  test "calculate_linestring_perimeter" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert_raise FunctionClauseError, fn -> GeoMeasure.Perimeter.calculate(geom) end
  end

  test "calculate_polygon_perimeter" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoMeasure.Perimeter.calculate(geom) == 8.0
  end

  test "calculate_polygon_perimeter_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {nil, 2}, {2, nil}, {2, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.Perimeter.calculate(geom) end
  end
end
