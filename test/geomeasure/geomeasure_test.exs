defmodule GeoMeasure.Test do
  use ExUnit.Case, async: true

  test "calculate_point_area" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert_raise FunctionClauseError, fn -> GeoMeasure.area(geom) end
  end

  test "calculate_linestring_area" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert_raise FunctionClauseError, fn -> GeoMeasure.area(geom) end
  end

  test "calculate_polygon_area" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoMeasure.area(geom) == 4.0
  end

  test "calculate_polygon_area_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, nil}, {2, 2}, {2, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.area(geom) end
  end

  test "calculate_point_bbox" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert GeoMeasure.bbox(geom) == %Geo.Point{coordinates: {1, 2}}
  end

  test "calculate_pointm_bbox" do
    geom = %Geo.PointM{coordinates: {1, 2, 5}}
    assert GeoMeasure.bbox(geom) == %Geo.Point{coordinates: {1, 2}}
  end

  test "calculate_pointz_bbox" do
    geom = %Geo.PointZ{coordinates: {1, 2, 5}}
    assert GeoMeasure.bbox(geom) == %Geo.PointZ{coordinates: {1, 2, 5}}
  end

  test "calculate_pointzm_bbox" do
    geom = %Geo.PointZM{coordinates: {1, 2, 5, 8}}
    assert GeoMeasure.bbox(geom) == %Geo.PointZ{coordinates: {1, 2, 5}}
  end

  test "calculate_linestring_bbox" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{1, 2}, {1, 4}, {3, 4}, {3, 2}, {1, 2}]]
           }
  end

  test "calculate_polygon_bbox" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]
           }
  end

  test "calculate_point_bbox_nil_coord" do
    geom = %Geo.Point{coordinates: {1, nil}}
    assert_raise ArgumentError, fn -> GeoMeasure.bbox(geom) end
  end

  test "calculate_pointm_bbox_nil_coord" do
    geom = %Geo.PointM{coordinates: {nil, 2, 5}}
    assert_raise ArgumentError, fn -> GeoMeasure.bbox(geom) end
  end

  test "calculate_pointm_bbox_nil_measure" do
    geom = %Geo.PointM{coordinates: {1, 2, nil}}
    assert GeoMeasure.bbox(geom) == %Geo.Point{coordinates: {1, 2}}
  end

  test "calculate_pointz_bbox_nil_coord" do
    geom = %Geo.PointZ{coordinates: {1, 2, nil}}
    assert_raise ArgumentError, fn -> GeoMeasure.bbox(geom) end
  end

  test "calculate_pointzm_bbox_nil_coord" do
    geom = %Geo.PointZM{coordinates: {1, nil, 5, 8}}
    assert_raise ArgumentError, fn -> GeoMeasure.bbox(geom) end
  end

  test "calculate_pointzm_bbox_nil_measure" do
    geom = %Geo.PointZM{coordinates: {1, 2, 5, nil}}
    assert GeoMeasure.bbox(geom) == %Geo.PointZ{coordinates: {1, 2, 5}}
  end

  test "calculate_linestring_bbox_nil_coord" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {nil, 4}]}
    assert_raise ArgumentError, fn -> GeoMeasure.bbox(geom) end
  end

  test "calculate_polygon_bbox_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, nil}, {2, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.bbox(geom) end
  end

  test "calculate_point_bbox_with_srid" do
    geom = %Geo.Point{coordinates: {1, 2}, srid: 27700}
    assert GeoMeasure.bbox(geom) == %Geo.Point{coordinates: {1, 2}, srid: 27700}
  end

  test "calculate_pointm_bbox_with_srid" do
    geom = %Geo.PointM{coordinates: {1, 2, 5}, srid: 27700}
    assert GeoMeasure.bbox(geom) == %Geo.Point{coordinates: {1, 2}, srid: 27700}
  end

  test "calculate_pointz_bbox_with_srid" do
    geom = %Geo.PointZ{coordinates: {1, 2, 5}, srid: 27700}
    assert GeoMeasure.bbox(geom) == %Geo.PointZ{coordinates: {1, 2, 5}, srid: 27700}
  end

  test "calculate_pointzm_bbox_with_srid" do
    geom = %Geo.PointZM{coordinates: {1, 2, 5, 8}, srid: 27700}
    assert GeoMeasure.bbox(geom) == %Geo.PointZ{coordinates: {1, 2, 5}, srid: 27700}
  end

  test "calculate_linestring_bbox_with_srid" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}], srid: 27700}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{1, 2}, {1, 4}, {3, 4}, {3, 2}, {1, 2}]],
             srid: 27700
           }
  end

  test "calculate_polygon_bbox_with_srid" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]], srid: 27700}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]],
             srid: 27700
           }
  end

  test "calculate_point_centroid" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {1, 2}}
  end

  test "calculate_pointm_centroid" do
    geom = %Geo.PointM{coordinates: {1, 2, 3}}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {1, 2}}
  end

  test "calculate_pointz_centroid" do
    geom = %Geo.PointZ{coordinates: {1, 2, 5}}
    assert GeoMeasure.centroid(geom) == %Geo.PointZ{coordinates: {1, 2, 5}}
  end

  test "calculate_pointzm_centroid" do
    geom = %Geo.PointZM{coordinates: {1, 2, 5, 8}}
    assert GeoMeasure.centroid(geom) == %Geo.PointZ{coordinates: {1, 2, 5}}
  end

  test "calculate_linestring_centroid" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {2.0, 3.0}}
  end

  test "calculate_linestringz_centroid" do
    geom = %Geo.LineStringZ{coordinates: [{1, 2, 3}, {3, 4, 5}]}
    assert GeoMeasure.centroid(geom) == %Geo.PointZ{coordinates: {2.0, 3.0, 4.0}}
  end

  test "calculate_linestringzm_centroid" do
    geom = %Geo.LineStringZM{coordinates: [{1, 2, 3, 10}, {3, 4, 5, 11}]}
    assert GeoMeasure.centroid(geom) == %Geo.PointZ{coordinates: {2.0, 3.0, 4.0}}
  end

  test "calculate_polygon_centroid" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {1.0, 1.0}}
  end

  test "calculate_point_centroid_nil_coord" do
    geom = %Geo.Point{coordinates: {nil, 2}}
    assert_raise ArgumentError, fn -> GeoMeasure.centroid(geom) end
  end

  test "calculate_pointm_centroid_nil_coord" do
    geom = %Geo.PointM{coordinates: {1, nil, 3}}
    assert_raise ArgumentError, fn -> GeoMeasure.centroid(geom) end
  end

  test "calculate_pointm_centroid_nil_measure" do
    geom = %Geo.PointM{coordinates: {1, 2, nil}}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {1, 2}}
  end

  test "calculate_pointz_centroid_nil_coord" do
    geom = %Geo.PointZ{coordinates: {1, 2, nil}}
    assert_raise ArgumentError, fn -> GeoMeasure.centroid(geom) end
  end

  test "calculate_pointzm_centroid_nil_coord" do
    geom = %Geo.PointZM{coordinates: {1, nil, 5, 8}}
    assert_raise ArgumentError, fn -> GeoMeasure.centroid(geom) end
  end

  test "calculate_pointzm_centroid_nil_measure" do
    geom = %Geo.PointZM{coordinates: {1, 2, 5, nil}}
    assert GeoMeasure.centroid(geom) == %Geo.PointZ{coordinates: {1, 2, 5}}
  end

  test "calculate_linestring_centroid_nil_coord" do
    geom = %Geo.LineString{coordinates: [{1, nil}, {3, 4}]}
    assert_raise ArgumentError, fn -> GeoMeasure.centroid(geom) end
  end

  test "calculate_linestringz_centroid_nil_coord" do
    geom = %Geo.LineStringZ{coordinates: [{1, 2, nil}, {3, 4, 5}]}
    assert_raise ArgumentError, fn -> GeoMeasure.centroid(geom) end
  end

  test "calculate_linestringzm_centroid_nil_coord" do
    geom = %Geo.LineStringZM{coordinates: [{1, 2, 3, 10}, {3, nil, 5, 11}]}
    assert_raise ArgumentError, fn -> GeoMeasure.centroid(geom) end
  end

  test "calculate_polygon_centroid_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {nil, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.centroid(geom) end
  end

  test "calculate_point_centroid_with_srid" do
    geom = %Geo.Point{coordinates: {1, 2}, srid: 23700}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {1, 2}, srid: 23700}
  end

  test "calculate_pointm_centroid_with_srid" do
    geom = %Geo.PointM{coordinates: {1, 2, 3}, srid: 23700}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {1, 2}, srid: 23700}
  end

  test "calculate_pointz_centroid_with_srid" do
    geom = %Geo.PointZ{coordinates: {1, 2, 5}, srid: 23700}
    assert GeoMeasure.centroid(geom) == %Geo.PointZ{coordinates: {1, 2, 5}, srid: 23700}
  end

  test "calculate_pointzm_centroid_with_srid" do
    geom = %Geo.PointZM{coordinates: {1, 2, 5, 8}, srid: 23700}
    assert GeoMeasure.centroid(geom) == %Geo.PointZ{coordinates: {1, 2, 5}, srid: 23700}
  end

  test "calculate_linestring_centroid_with_srid" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}], srid: 23700}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {2.0, 3.0}, srid: 23700}
  end

  test "calculate_linestringz_centroid_with_srid" do
    geom = %Geo.LineStringZ{coordinates: [{1, 2, 3}, {3, 4, 5}], srid: 23700}

    assert GeoMeasure.centroid(geom) == %Geo.PointZ{
             coordinates: {2.0, 3.0, 4.0},
             srid: 23700
           }
  end

  test "calculate_linestringzm_centroid_with_srid" do
    geom = %Geo.LineStringZM{coordinates: [{1, 2, 3, 10}, {3, 4, 5, 11}], srid: 23700}

    assert GeoMeasure.centroid(geom) == %Geo.PointZ{
             coordinates: {2.0, 3.0, 4.0},
             srid: 23700
           }
  end

  test "calculate_polygon_centroid_with_srid" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]], srid: 23700}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {1.0, 1.0}, srid: 23700}
  end

  test "calculate_distance_x_direction" do
    a = {0, 0}
    b = {5, 0}
    assert GeoMeasure.distance(a, b) == 5.0
  end

  test "calculate_distance_y_direction" do
    a = {0, 0}
    b = {0, 5}
    assert GeoMeasure.distance(a, b) == 5.0
  end

  test "calculate_distance_xy_direction" do
    a = {0, 0}
    b = {3, 4}
    assert GeoMeasure.distance(a, b) == 5.0
  end

  test "calculate_3d_distance_x_direction" do
    a = {0, 0, 0}
    b = {5, 0, 0}
    assert GeoMeasure.distance(a, b) == 5.0
  end

  test "calculate_3d_distance_y_direction" do
    a = {0, 0, 0}
    b = {0, 5, 0}
    assert GeoMeasure.distance(a, b) == 5.0
  end

  test "calculate_3d_distance_xy_direction" do
    a = {0, 0, 0}
    b = {3, 4, 0}
    assert GeoMeasure.distance(a, b) == 5.0
  end

  test "calculate_3d_distance_xyz_direction" do
    a = {0, 0, 0}
    b = {1, 1, 1}
    assert GeoMeasure.distance(a, b) == 1.7320508075688772
  end

  test "calculate_distance_x_direction_point" do
    a = %Geo.Point{coordinates: {0, 0}}
    b = %Geo.Point{coordinates: {5, 0}}
    assert GeoMeasure.distance(a, b) == 5.0
  end

  test "calculate_distance_y_direction_point" do
    a = %Geo.Point{coordinates: {0, 0}}
    b = %Geo.Point{coordinates: {0, 5}}
    assert GeoMeasure.distance(a, b) == 5.0
  end

  test "calculate_distance_xy_direction_point" do
    a = %Geo.Point{coordinates: {0, 0}}
    b = %Geo.Point{coordinates: {3, 4}}
    assert GeoMeasure.distance(a, b) == 5.0
  end

  test "calculate_distance_xy_direction_pointm" do
    a = %Geo.PointM{coordinates: {0, 0, 5}}
    b = %Geo.PointM{coordinates: {3, 4, 5}}
    assert GeoMeasure.distance(a, b) == 5.0
  end

  test "calculate_3d_distance_xyz_direction_pointz" do
    a = %Geo.PointZ{coordinates: {0, 0, 0}}
    b = %Geo.PointZ{coordinates: {1, 1, 1}}
    assert GeoMeasure.distance(a, b) == 1.7320508075688772
  end

  test "calculate_3d_distance_xyz_direction_pointzm" do
    a = %Geo.PointZM{coordinates: {0, 0, 0, 5}}
    b = %Geo.PointZM{coordinates: {1, 1, 1, 5}}
    assert GeoMeasure.distance(a, b) == 1.7320508075688772
  end

  test "calculate_distance_xy_direction_nil_coord" do
    a = {0, nil}
    b = {3, 4}
    assert_raise ArgumentError, fn -> GeoMeasure.distance(a, b) end
  end

  test "calculate_distance_xy_direction_point_nil_coord" do
    a = %Geo.Point{coordinates: {0, 0}}
    b = %Geo.Point{coordinates: {nil, 4}}
    assert_raise ArgumentError, fn -> GeoMeasure.distance(a, b) end
  end

  test "calculate_distance_xy_direction_pointm_nil_coord" do
    a = %Geo.PointM{coordinates: {0, 0, 5}}
    b = %Geo.PointM{coordinates: {3, nil, 5}}
    assert_raise ArgumentError, fn -> GeoMeasure.distance(a, b) end
  end

  test "calculate_distance_xy_direction_pointm_nil_measure" do
    a = %Geo.PointM{coordinates: {0, 0, nil}}
    b = %Geo.PointM{coordinates: {3, 4, 5}}
    assert GeoMeasure.distance(a, b) == 5.0
  end

  test "calculate_3d_distance_xyz_direction_pointz_nil_coord" do
    a = %Geo.PointZ{coordinates: {0, nil, 0}}
    b = %Geo.PointZ{coordinates: {1, 1, 1}}
    assert_raise ArgumentError, fn -> GeoMeasure.distance(a, b) end
  end

  test "calculate_3d_distance_xyz_direction_pointzm_nil_measure" do
    a = %Geo.PointZM{coordinates: {0, 0, 0, nil}}
    b = %Geo.PointZM{coordinates: {1, 1, 1, nil}}
    assert GeoMeasure.distance(a, b) == 1.7320508075688772
  end

  test "calculate_3d_distance_xyz_direction_pointzm_nil_coord" do
    a = %Geo.PointZM{coordinates: {0, 0, nil, 5}}
    b = %Geo.PointZM{coordinates: {1, 1, 1, 5}}
    assert_raise ArgumentError, fn -> GeoMeasure.distance(a, b) end
  end

  test "calculate_point_extent" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert_raise FunctionClauseError, fn -> GeoMeasure.extent(geom) end
  end

  test "calculate_linestring_extent" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert GeoMeasure.extent(geom) == {1, 3, 2, 4}
  end

  test "calculate_linestringz_extent" do
    geom = %Geo.LineStringZ{coordinates: [{1, 2, 3}, {3, 4, 5}]}
    assert GeoMeasure.extent(geom) == {1, 3, 2, 4, 3, 5}
  end

  test "calculate_linestringzm_extent" do
    geom = %Geo.LineStringZM{coordinates: [{1, 2, 3, 10}, {3, 4, 5, 11}]}
    assert GeoMeasure.extent(geom) == {1, 3, 2, 4, 3, 5}
  end

  test "calculate_polygon_extent" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoMeasure.extent(geom) == {0, 2, 0, 2}
  end

  test "calculate_linestring_extent_nil_coord" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {nil, 4}]}
    assert_raise ArgumentError, fn -> GeoMeasure.extent(geom) end
  end

  test "calculate_linestringz_extent_nil_coord" do
    geom = %Geo.LineStringZ{coordinates: [{1, 2, nil}, {3, 4, 5}]}
    assert_raise ArgumentError, fn -> GeoMeasure.extent(geom) end
  end

  test "calculate_linestringzm_extent_nil_coord" do
    geom = %Geo.LineStringZM{coordinates: [{1, 2, 3, 10}, {3, nil, 5, 11}]}
    assert_raise ArgumentError, fn -> GeoMeasure.extent(geom) end
  end

  test "calculate_polygon_extent_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {nil, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.extent(geom) end
  end

  test "calculate_point_perimeter" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert_raise FunctionClauseError, fn -> GeoMeasure.perimeter(geom) end
  end

  test "calculate_pointm_perimeter" do
    geom = %Geo.PointM{coordinates: {1, 2}}
    assert_raise FunctionClauseError, fn -> GeoMeasure.perimeter(geom) end
  end

  test "calculate_pointz_perimeter" do
    geom = %Geo.PointZ{coordinates: {1, 2}}
    assert_raise FunctionClauseError, fn -> GeoMeasure.perimeter(geom) end
  end

  test "calculate_pointzm_perimeter" do
    geom = %Geo.PointZM{coordinates: {1, 2}}
    assert_raise FunctionClauseError, fn -> GeoMeasure.perimeter(geom) end
  end

  test "calculate_linestring_length" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {1, 4}]}
    assert GeoMeasure.length(geom) == 2.0
  end

  test "calculate_linestringz_length" do
    geom = %Geo.LineStringZ{coordinates: [{1, 2, 2}, {1, 4, 2}]}
    assert GeoMeasure.length(geom) == 2.0
  end

  test "calculate_linestringzm_length" do
    geom = %Geo.LineStringZM{coordinates: [{1, 2, 2, 10}, {1, 4, 2, 11}]}
    assert GeoMeasure.length(geom) == 2.0
  end

  test "calculate_polygon_perimeter" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoMeasure.perimeter(geom) == 8.0
  end

  test "calculate_linestring_length_nil_coord" do
    geom = %Geo.LineString{coordinates: [{1, nil}, {1, 4}]}
    assert_raise ArgumentError, fn -> GeoMeasure.length(geom) end
  end

  test "calculate_linestringz_length_nil_coord" do
    geom = %Geo.LineStringZ{coordinates: [{1, 2, 2}, {1, nil, 2}]}
    assert_raise ArgumentError, fn -> GeoMeasure.length(geom) end
  end

  test "calculate_linestringzm_length_nil_coord" do
    geom = %Geo.LineStringZM{coordinates: [{nil, 2, 2, 10}, {1, 4, 2, 11}]}
    assert_raise ArgumentError, fn -> GeoMeasure.length(geom) end
  end

  test "calculate_polygon_perimeter_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {nil, 2}, {2, nil}, {2, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.perimeter(geom) end
  end
end
