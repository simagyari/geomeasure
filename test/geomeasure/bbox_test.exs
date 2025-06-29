defmodule GeoMeasure.Bbox.Test do
  use ExUnit.Case, async: true

  test "calculate_point_bbox" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert GeoMeasure.Bbox.calculate(geom) == %Geo.Point{coordinates: {1, 2}}
  end

  test "calculate_pointm_bbox" do
    geom = %Geo.PointM{coordinates: {1, 2, 5}}
    assert GeoMeasure.Bbox.calculate(geom) == %Geo.Point{coordinates: {1, 2}}
  end

  test "calculate_pointz_bbox" do
    geom = %Geo.PointZ{coordinates: {1, 2, 5}}
    assert GeoMeasure.Bbox.calculate(geom) == %Geo.PointZ{coordinates: {1, 2, 5}}
  end

  test "calculate_pointzm_bbox" do
    geom = %Geo.PointZM{coordinates: {1, 2, 5, 8}}
    assert GeoMeasure.Bbox.calculate(geom) == %Geo.PointZ{coordinates: {1, 2, 5}}
  end

  test "calculate_linestring_bbox" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}

    assert GeoMeasure.Bbox.calculate(geom) == %Geo.Polygon{
             coordinates: [[{1, 2}, {1, 4}, {3, 4}, {3, 2}, {1, 2}]]
           }
  end

  test "calculate_polygon_bbox" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}

    assert GeoMeasure.Bbox.calculate(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]
           }
  end

  test "calculate_point_bbox_nil_coord" do
    geom = %Geo.Point{coordinates: {1, nil}}
    assert_raise ArgumentError, fn -> GeoMeasure.Bbox.calculate(geom) end
  end

  test "calculate_pointm_bbox_nil_coord" do
    geom = %Geo.PointM{coordinates: {nil, 2, 5}}
    assert_raise ArgumentError, fn -> GeoMeasure.Bbox.calculate(geom) end
  end

  test "calculate_pointm_bbox_nil_measure" do
    geom = %Geo.PointM{coordinates: {1, 2, nil}}
    assert GeoMeasure.Bbox.calculate(geom) == %Geo.Point{coordinates: {1, 2}}
  end

  test "calculate_pointz_bbox_nil_coord" do
    geom = %Geo.PointZ{coordinates: {1, 2, nil}}
    assert_raise ArgumentError, fn -> GeoMeasure.Bbox.calculate(geom) end
  end

  test "calculate_pointzm_bbox_nil_coord" do
    geom = %Geo.PointZM{coordinates: {1, nil, 5, 8}}
    assert_raise ArgumentError, fn -> GeoMeasure.Bbox.calculate(geom) end
  end

  test "calculate_pointzm_bbox_nil_measure" do
    geom = %Geo.PointZM{coordinates: {1, 2, 5, nil}}
    assert GeoMeasure.Bbox.calculate(geom) == %Geo.PointZ{coordinates: {1, 2, 5}}
  end

  test "calculate_linestring_bbox_nil_coord" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {nil, 4}]}
    assert_raise ArgumentError, fn -> GeoMeasure.Bbox.calculate(geom) end
  end

  test "calculate_polygon_bbox_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, nil}, {2, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.Bbox.calculate(geom) end
  end

  test "calculate_point_bbox_with_srid" do
    geom = %Geo.Point{coordinates: {1, 2}, srid: 27700}
    assert GeoMeasure.Bbox.calculate(geom) == %Geo.Point{coordinates: {1, 2}, srid: 27700}
  end

  test "calculate_pointm_bbox_with_srid" do
    geom = %Geo.PointM{coordinates: {1, 2, 5}, srid: 27700}
    assert GeoMeasure.Bbox.calculate(geom) == %Geo.Point{coordinates: {1, 2}, srid: 27700}
  end

  test "calculate_pointz_bbox_with_srid" do
    geom = %Geo.PointZ{coordinates: {1, 2, 5}, srid: 27700}
    assert GeoMeasure.Bbox.calculate(geom) == %Geo.PointZ{coordinates: {1, 2, 5}, srid: 27700}
  end

  test "calculate_pointzm_bbox_with_srid" do
    geom = %Geo.PointZM{coordinates: {1, 2, 5, 8}, srid: 27700}
    assert GeoMeasure.Bbox.calculate(geom) == %Geo.PointZ{coordinates: {1, 2, 5}, srid: 27700}
  end

  test "calculate_linestring_bbox_with_srid" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}], srid: 27700}

    assert GeoMeasure.Bbox.calculate(geom) == %Geo.Polygon{
             coordinates: [[{1, 2}, {1, 4}, {3, 4}, {3, 2}, {1, 2}]],
             srid: 27700
           }
  end

  test "calculate_polygon_bbox_with_srid" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]], srid: 27700}

    assert GeoMeasure.Bbox.calculate(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]],
             srid: 27700
           }
  end
end
