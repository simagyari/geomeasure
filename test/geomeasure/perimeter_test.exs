defmodule GeoMeasure.Perimeter.Test do
  use ExUnit.Case, async: true

  test "calculate_point_perimeter" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert_raise FunctionClauseError, fn -> GeoMeasure.Perimeter.calculate(geom) end
  end

  test "calculate_pointm_perimeter" do
    geom = %Geo.PointM{coordinates: {1, 2}}
    assert_raise FunctionClauseError, fn -> GeoMeasure.Perimeter.calculate(geom) end
  end

  test "calculate_pointz_perimeter" do
    geom = %Geo.PointZ{coordinates: {1, 2}}
    assert_raise FunctionClauseError, fn -> GeoMeasure.Perimeter.calculate(geom) end
  end

  test "calculate_pointzm_perimeter" do
    geom = %Geo.PointZM{coordinates: {1, 2}}
    assert_raise FunctionClauseError, fn -> GeoMeasure.Perimeter.calculate(geom) end
  end

  test "calculate_linestring_length" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {1, 4}]}
    assert GeoMeasure.Perimeter.calculate(geom) == 2.0
  end

  test "calculate_linestringz_length" do
    geom = %Geo.LineStringZ{coordinates: [{1, 2, 2}, {1, 4, 2}]}
    assert GeoMeasure.Perimeter.calculate(geom) == 2.0
  end

  test "calculate_linestringzm_length" do
    geom = %Geo.LineStringZM{coordinates: [{1, 2, 2, 10}, {1, 4, 2, 11}]}
    assert GeoMeasure.Perimeter.calculate(geom) == 2.0
  end

  test "calculate_polygon_perimeter" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoMeasure.Perimeter.calculate(geom) == 8.0
  end

  test "calculate_polygon_perimeter_hole" do
    geom = %Geo.Polygon{
      coordinates: [
        [{0, 0}, {0, 3}, {3, 3}, {3, 0}, {0, 0}],
        [{1, 1}, {1, 2}, {2, 2}, {2, 1}, {1, 1}]
      ]
    }

    assert GeoMeasure.Perimeter.calculate(geom) == 16.0
  end

  test "calculate_linestring_length_nil_coord" do
    geom = %Geo.LineString{coordinates: [{1, nil}, {1, 4}]}
    assert_raise ArgumentError, fn -> GeoMeasure.Perimeter.calculate(geom) end
  end

  test "calculate_linestringz_length_nil_coord" do
    geom = %Geo.LineStringZ{coordinates: [{1, 2, 2}, {1, nil, 2}]}
    assert_raise ArgumentError, fn -> GeoMeasure.Perimeter.calculate(geom) end
  end

  test "calculate_linestringzm_length_nil_coord" do
    geom = %Geo.LineStringZM{coordinates: [{nil, 2, 2, 10}, {1, 4, 2, 11}]}
    assert_raise ArgumentError, fn -> GeoMeasure.Perimeter.calculate(geom) end
  end

  test "calculate_polygon_perimeter_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {nil, 2}, {2, nil}, {2, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.Perimeter.calculate(geom) end
  end
end
