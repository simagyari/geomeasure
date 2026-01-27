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

  test "calculate_linestringm_extent" do
    geom = %Geo.LineStringM{coordinates: [{1, 2, 5}, {3, 4, 5}]}
    assert GeoMeasure.Extent.calculate(geom) == {1, 3, 2, 4}
  end

  test "calculate_linestringz_extent" do
    geom = %Geo.LineStringZ{coordinates: [{1, 2, 3}, {3, 4, 5}]}
    assert GeoMeasure.Extent.calculate(geom) == {1, 3, 2, 4, 3, 5}
  end

  test "calculate_linestringzm_extent" do
    geom = %Geo.LineStringZM{coordinates: [{1, 2, 3, 10}, {3, 4, 5, 11}]}
    assert GeoMeasure.Extent.calculate(geom) == {1, 3, 2, 4, 3, 5}
  end

  test "calculate_multilinestring_extent" do
    geom = %Geo.MultiLineString{coordinates: [[{1, 2}, {3, 4}], [{0, -1}, {2, 3}]]}
    assert GeoMeasure.Extent.calculate(geom) == {0, 3, -1, 4}
  end

  test "calculate_multilinestringz_extent" do
    geom = %Geo.MultiLineStringZ{coordinates: [[{1, 2, 3}, {3, 4, 5}], [{0, -1, 2}, {2, 3, 4}]]}
    assert GeoMeasure.Extent.calculate(geom) == {0, 3, -1, 4, 2, 5}
  end

  test "calculate_polygon_extent" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoMeasure.Extent.calculate(geom) == {0, 2, 0, 2}
  end

  test "calculate_polygonz_extent" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]]}
    assert GeoMeasure.Extent.calculate(geom) == {0, 2, 0, 2, 0, 2}
  end

  test "calculate_multipolygon_extent" do
    geom = %Geo.MultiPolygon{coordinates: [[[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]], [[{1, 1}, {1, 3}, {3, 3}, {3, 1}, {1, 1}]]]}
    assert GeoMeasure.Extent.calculate(geom) == {0, 3, 0, 3}
  end

  test "calculate_multipolygonz_extent" do
    geom = %Geo.MultiPolygonZ{coordinates: [[[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]], [[{1, 1, 1}, {1, 3, 2}, {3, 3, 3}, {3, 1, 2}, {1, 1, 1}]]]}
    assert GeoMeasure.Extent.calculate(geom) == {0, 3, 0, 3, 0, 3}
  end

  test "calculate_multipoint_extent" do
    geom = %Geo.MultiPoint{coordinates: [{1, 2}, {3, 4}, {0, -1}]}
    assert GeoMeasure.Extent.calculate(geom) == {0, 3, -1, 4}
  end

  test "calculate_multipointz_extent" do
    geom = %Geo.MultiPointZ{coordinates: [{1, 2, 3}, {3, 4, 5}, {0, -1, 2}]}
    assert GeoMeasure.Extent.calculate(geom) == {0, 3, -1, 4, 2, 5}
  end

  test "calculate_multipoint_extent_nil_coord" do
    geom = %Geo.MultiPoint{coordinates: [{1, 2}, {nil, 4}, {0, -1}]}
    assert_raise ArgumentError, fn -> GeoMeasure.Extent.calculate(geom) end
  end

  test "calculate_multipointz_extent_nil_coord" do
    geom = %Geo.MultiPointZ{coordinates: [{1, 2, 3}, {nil, 4, 5}, {0, -1, 2}]}
    assert_raise ArgumentError, fn -> GeoMeasure.Extent.calculate(geom) end
  end

  test "calculate_linestring_extent_nil_coord" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {nil, 4}]}
    assert_raise ArgumentError, fn -> GeoMeasure.Extent.calculate(geom) end
  end

  test "calculate_linestringm_extent_nil_coord" do
    geom = %Geo.LineStringM{coordinates: [{1, 2, 5}, {nil, 4, 5}]}
    assert_raise ArgumentError, fn -> GeoMeasure.Extent.calculate(geom) end
  end

  test "calculate_linestringz_extent_nil_coord" do
    geom = %Geo.LineStringZ{coordinates: [{1, 2, nil}, {3, 4, 5}]}
    assert_raise ArgumentError, fn -> GeoMeasure.Extent.calculate(geom) end
  end

  test "calculate_linestringzm_extent_nil_coord" do
    geom = %Geo.LineStringZM{coordinates: [{1, 2, 3, 10}, {3, nil, 5, 11}]}
    assert_raise ArgumentError, fn -> GeoMeasure.Extent.calculate(geom) end
  end

  test "calculate_multilinestring_extent_nil_coord" do
    geom = %Geo.MultiLineString{coordinates: [[{1, 2}, {nil, 4}], [{0, -1}, {2, 3}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.Extent.calculate(geom) end
  end

  test "calculate_multilinestringz_extent_nil_coord" do
    geom = %Geo.MultiLineStringZ{coordinates: [[{1, 2, 3}, {nil, 4, 5}], [{0, -1, 2}, {2, 3, 4}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.Extent.calculate(geom) end
  end

  test "calculate_polygon_extent_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {nil, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.Extent.calculate(geom) end
  end

  test "calculate_polygonz_extent_nil_coord" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, nil, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.Extent.calculate(geom) end
  end

  test "calculate_multipolygon_extent_nil_coord" do
    geom = %Geo.MultiPolygon{coordinates: [[[{0, 0}, {0, 2}, {nil, 2}, {2, 0}, {0, 0}]], [[{1, 1}, {1, 3}, {3, 3}, {3, 1}, {1, 1}]]]}
    assert_raise ArgumentError, fn -> GeoMeasure.Extent.calculate(geom) end
  end

  test "calculate_multipolygonz_extent_nil_coord" do
    geom = %Geo.MultiPolygonZ{coordinates: [[[{0, 0, 0}, {0, 2, 1}, {nil, 2, 2}, {2, 0, 1}, {0, 0, 0}]], [[{1, 1, 1}, {1, 3, 2}, {3, 3, 3}, {3, 1, 2}, {1, 1, 1}]]]}
    assert_raise ArgumentError, fn -> GeoMeasure.Extent.calculate(geom) end
  end
end
