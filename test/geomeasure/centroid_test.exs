defmodule GeoMeasure.Centroid.Test do
  use ExUnit.Case, async: true

  test "calculate_point_centroid" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert GeoMeasure.Centroid.calculate(geom) == %Geo.Point{coordinates: {1, 2}}
  end

  test "calculate_pointm_centroid" do
    geom = %Geo.PointM{coordinates: {1, 2, 3}}
    assert GeoMeasure.Centroid.calculate(geom) == %Geo.Point{coordinates: {1, 2}}
  end

  test "calculate_pointz_centroid" do
    geom = %Geo.PointZ{coordinates: {1, 2, 5}}
    assert GeoMeasure.Centroid.calculate(geom) == %Geo.PointZ{coordinates: {1, 2, 5}}
  end

  test "calculate_pointzm_centroid" do
    geom = %Geo.PointZM{coordinates: {1, 2, 5, 8}}
    assert GeoMeasure.Centroid.calculate(geom) == %Geo.PointZ{coordinates: {1, 2, 5}}
  end

  test "calculate_linestring_centroid" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert GeoMeasure.Centroid.calculate(geom) == %Geo.Point{coordinates: {2.0, 3.0}}
  end

  test "calculate_linestringm_centroid" do
    geom = %Geo.LineStringM{coordinates: [{1, 2, 5}, {3, 4, 5}]}
    assert GeoMeasure.Centroid.calculate(geom) == %Geo.Point{coordinates: {2.0, 3.0}}
  end

  test "calculate_linestringz_centroid" do
    geom = %Geo.LineStringZ{coordinates: [{1, 2, 3}, {3, 4, 5}]}
    assert GeoMeasure.Centroid.calculate(geom) == %Geo.PointZ{coordinates: {2.0, 3.0, 4.0}}
  end

  test "calculate_linestringzm_centroid" do
    geom = %Geo.LineStringZM{coordinates: [{1, 2, 3, 10}, {3, 4, 5, 11}]}
    assert GeoMeasure.Centroid.calculate(geom) == %Geo.PointZ{coordinates: {2.0, 3.0, 4.0}}
  end

  test "calculate_polygon_centroid" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoMeasure.Centroid.calculate(geom) == %Geo.Point{coordinates: {1.0, 1.0}}
  end

  test "calculate_polygonz_centroid" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]]}
    assert GeoMeasure.Centroid.calculate(geom) == %Geo.PointZ{coordinates: {1.0, 1.0, 1.0}}
  end

  test "calculate_point_centroid_nil_coord" do
    geom = %Geo.Point{coordinates: {nil, 2}}
    assert_raise ArgumentError, fn -> GeoMeasure.Centroid.calculate(geom) end
  end

  test "calculate_pointm_centroid_nil_coord" do
    geom = %Geo.PointM{coordinates: {1, nil, 3}}
    assert_raise ArgumentError, fn -> GeoMeasure.Centroid.calculate(geom) end
  end

  test "calculate_pointm_centroid_nil_measure" do
    geom = %Geo.PointM{coordinates: {1, 2, nil}}
    assert GeoMeasure.Centroid.calculate(geom) == %Geo.Point{coordinates: {1, 2}}
  end

  test "calculate_pointz_centroid_nil_coord" do
    geom = %Geo.PointZ{coordinates: {1, 2, nil}}
    assert_raise ArgumentError, fn -> GeoMeasure.Centroid.calculate(geom) end
  end

  test "calculate_pointzm_centroid_nil_coord" do
    geom = %Geo.PointZM{coordinates: {1, nil, 5, 8}}
    assert_raise ArgumentError, fn -> GeoMeasure.Centroid.calculate(geom) end
  end

  test "calculate_pointzm_centroid_nil_measure" do
    geom = %Geo.PointZM{coordinates: {1, 2, 5, nil}}
    assert GeoMeasure.Centroid.calculate(geom) == %Geo.PointZ{coordinates: {1, 2, 5}}
  end

  test "calculate_linestring_centroid_nil_coord" do
    geom = %Geo.LineString{coordinates: [{1, nil}, {3, 4}]}
    assert_raise ArgumentError, fn -> GeoMeasure.Centroid.calculate(geom) end
  end

  test "calculate_linestringm_centroid_nil_coord" do
    geom = %Geo.LineStringM{coordinates: [{1, nil, 5}, {3, 4, 5}]}
    assert_raise ArgumentError, fn -> GeoMeasure.Centroid.calculate(geom) end
  end

  test "calculate_linestringz_centroid_nil_coord" do
    geom = %Geo.LineStringZ{coordinates: [{1, 2, nil}, {3, 4, 5}]}
    assert_raise ArgumentError, fn -> GeoMeasure.Centroid.calculate(geom) end
  end

  test "calculate_linestringzm_centroid_nil_coord" do
    geom = %Geo.LineStringZM{coordinates: [{1, 2, 3, 10}, {3, nil, 5, 11}]}
    assert_raise ArgumentError, fn -> GeoMeasure.Centroid.calculate(geom) end
  end

  test "calculate_polygon_centroid_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {nil, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.Centroid.calculate(geom) end
  end

  test "calculate_polygonz_centroid_nil_coord" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, nil, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.Centroid.calculate(geom) end
  end

  test "calculate_point_centroid_with_srid" do
    geom = %Geo.Point{coordinates: {1, 2}, srid: 23700}
    assert GeoMeasure.Centroid.calculate(geom) == %Geo.Point{coordinates: {1, 2}, srid: 23700}
  end

  test "calculate_pointm_centroid_with_srid" do
    geom = %Geo.PointM{coordinates: {1, 2, 3}, srid: 23700}
    assert GeoMeasure.Centroid.calculate(geom) == %Geo.Point{coordinates: {1, 2}, srid: 23700}
  end

  test "calculate_pointz_centroid_with_srid" do
    geom = %Geo.PointZ{coordinates: {1, 2, 5}, srid: 23700}
    assert GeoMeasure.Centroid.calculate(geom) == %Geo.PointZ{coordinates: {1, 2, 5}, srid: 23700}
  end

  test "calculate_pointzm_centroid_with_srid" do
    geom = %Geo.PointZM{coordinates: {1, 2, 5, 8}, srid: 23700}
    assert GeoMeasure.Centroid.calculate(geom) == %Geo.PointZ{coordinates: {1, 2, 5}, srid: 23700}
  end

  test "calculate_linestring_centroid_with_srid" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}], srid: 23700}
    assert GeoMeasure.Centroid.calculate(geom) == %Geo.Point{coordinates: {2.0, 3.0}, srid: 23700}
  end

  test "calculate_linestringm_centroid_with_srid" do
    geom = %Geo.LineStringM{coordinates: [{1, 2, 5}, {3, 4, 5}], srid: 23700}
    assert GeoMeasure.Centroid.calculate(geom) == %Geo.Point{coordinates: {2.0, 3.0}, srid: 23700}
  end

  test "calculate_linestringz_centroid_with_srid" do
    geom = %Geo.LineStringZ{coordinates: [{1, 2, 3}, {3, 4, 5}], srid: 23700}

    assert GeoMeasure.Centroid.calculate(geom) == %Geo.PointZ{
             coordinates: {2.0, 3.0, 4.0},
             srid: 23700
           }
  end

  test "calculate_linestringzm_centroid_with_srid" do
    geom = %Geo.LineStringZM{coordinates: [{1, 2, 3, 10}, {3, 4, 5, 11}], srid: 23700}

    assert GeoMeasure.Centroid.calculate(geom) == %Geo.PointZ{
             coordinates: {2.0, 3.0, 4.0},
             srid: 23700
           }
  end

  test "calculate_polygon_centroid_with_srid" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]], srid: 23700}
    assert GeoMeasure.Centroid.calculate(geom) == %Geo.Point{coordinates: {1.0, 1.0}, srid: 23700}
  end

  test "calculate_polygonz_centroid_with_srid" do
    geom = %Geo.PolygonZ{
      coordinates: [[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]],
      srid: 23700
    }

    assert GeoMeasure.Centroid.calculate(geom) == %Geo.PointZ{
             coordinates: {1.0, 1.0, 1.0},
             srid: 23700
           }
  end
end
