defmodule GeoProperties.Test do
  use ExUnit.Case, async: true

  test "calculate_point_area" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert GeoProperties.area(geom) == nil
  end

  test "calculate_linestring_area" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert GeoProperties.area(geom) == nil
  end

  test "calculate_polygon_area" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoProperties.area(geom) == 4.0
  end

  test "calculate_point_bbox" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert GeoProperties.bbox(geom) == %Geo.Point{coordinates: {1, 2}}
  end

  test "calculate_linestring_bbox" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert GeoProperties.bbox(geom) == %Geo.Polygon{coordinates: [[{1, 2}, {1, 4}, {3, 4}, {3, 2}, {1, 2}]]}
  end

  test "calculate_polygon_bbox" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoProperties.bbox(geom) == %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
  end

  test "calculate_point_centroid" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert GeoProperties.centroid(geom) == %Geo.Point{coordinates: {1, 2}}
  end

  test "calculate_linestring_centroid" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert GeoProperties.centroid(geom) == %Geo.Point{coordinates: {2.0, 3.0}}
  end

  test "calculate_polygon_centroid" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoProperties.centroid(geom) == %Geo.Point{coordinates: {1.0, 1.0}}
  end

  test "calculate_point_extent" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert GeoProperties.extent(geom) == nil
  end

  test "calculate_linestring_extent" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert GeoProperties.extent(geom) == {1, 3, 2, 4}
  end

  test "calculate_polygon_extent" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoProperties.extent(geom) == {0, 2, 0, 2}
  end

  test "calculate_point_perimeter" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert GeoProperties.perimeter(geom) == nil
  end

  test "calculate_linestring_perimeter" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert GeoProperties.perimeter(geom) == nil
  end

  test "calculate_polygon_perimeter" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoProperties.perimeter(geom) == 8.0
  end
end
