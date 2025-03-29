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

  test "calculate_linestring_bbox_nil_coord" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {nil, 4}]}
    assert_raise ArgumentError, fn -> GeoMeasure.bbox(geom) end
  end

  test "calculate_polygon_bbox_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, nil}, {2, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.bbox(geom) end
  end

  test "calculate_point_centroid" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {1, 2}}
  end

  test "calculate_linestring_centroid" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {2.0, 3.0}}
  end

  test "calculate_polygon_centroid" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {1.0, 1.0}}
  end

  test "calculate_point_centroid_nil_coord" do
    geom = %Geo.Point{coordinates: {nil, 2}}
    assert_raise ArgumentError, fn -> GeoMeasure.centroid(geom) end
  end

  test "calculate_linestring_centroid_nil_coord" do
    geom = %Geo.LineString{coordinates: [{1, nil}, {3, 4}]}
    assert_raise ArgumentError, fn -> GeoMeasure.centroid(geom) end
  end

  test "calculate_polygon_centroid_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {nil, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.centroid(geom) end
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

  test "calculate_point_extent" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert_raise FunctionClauseError, fn -> GeoMeasure.extent(geom) end
  end

  test "calculate_linestring_extent" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert GeoMeasure.extent(geom) == {1, 3, 2, 4}
  end

  test "calculate_polygon_extent" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoMeasure.extent(geom) == {0, 2, 0, 2}
  end

  test "calculate_linestring_extent_nil_coord" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {nil, 4}]}
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

  test "calculate_linestring_perimeter" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert_raise FunctionClauseError, fn -> GeoMeasure.perimeter(geom) end
  end

  test "calculate_polygon_perimeter" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoMeasure.perimeter(geom) == 8.0
  end

  test "calculate_polygon_perimeter_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {nil, 2}, {2, nil}, {2, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.perimeter(geom) end
  end
end
