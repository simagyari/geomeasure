defmodule GeoMeasure.Bbox.Test do
  use ExUnit.Case, async: true

  test "calculate_point_bbox" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert GeoMeasure.Bbox.bbox(geom) == %Geo.Point{coordinates: {1, 2}}
  end

  test "calculate_linestring_bbox" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}

    assert GeoMeasure.Bbox.bbox(geom) == %Geo.Polygon{
             coordinates: [[{1, 2}, {1, 4}, {3, 4}, {3, 2}, {1, 2}]]
           }
  end

  test "calculate_polygon_bbox" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}

    assert GeoMeasure.Bbox.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]
           }
  end
end
