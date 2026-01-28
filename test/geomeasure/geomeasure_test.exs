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

  test "calculate_polygonz_area" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {4, 0, 3}, {0, 0, 0}]]}
    assert GeoMeasure.area(geom) == 25.0
  end

  test "calculate_multipolygon_area" do
    geom = %Geo.MultiPolygon{
      coordinates: [
        [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]],
        [[{1, 1}, {1, 3}, {3, 3}, {3, 1}, {1, 1}]]
      ]
    }

    assert GeoMeasure.area(geom) == 8.0
  end

  test "calculate_multipolygonz_area" do
    geom = %Geo.MultiPolygonZ{
      coordinates: [
        [[{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {4, 0, 3}, {0, 0, 0}]],
        [[{1, 1, 1}, {1, 6, 1}, {5, 6, 4}, {5, 1, 4}, {1, 1, 1}]]
      ]
    }

    assert GeoMeasure.area(geom) == 50.0
  end

  test "calculate_polygon_area_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, nil}, {2, 2}, {2, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.area(geom) end
  end

  test "calculate_polygonz_area_nil_coord" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {nil, 0, 3}, {0, 0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.area(geom) end
  end

  test "calculate_multipolygon_area_nil_coord" do
    geom = %Geo.MultiPolygon{
      coordinates: [
        [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]],
        [[{1, 1}, {1, nil}, {3, 3}, {3, 1}, {1, 1}]]
      ]
    }

    assert_raise ArgumentError, fn -> GeoMeasure.area(geom) end
  end

  test "calculate_multipolygonz_area_nil_coord" do
    geom = %Geo.MultiPolygonZ{
      coordinates: [
        [[{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {4, 0, 3}, {0, 0, 0}]],
        [[{1, 1, 1}, {1, 6, nil}, {5, 6, 4}, {5, 1, 4}, {1, 1, 1}]]
      ]
    }

    assert_raise ArgumentError, fn -> GeoMeasure.area(geom) end
  end

  test "calculate_polygon_area_hole" do
    geom = %Geo.Polygon{
      coordinates: [
        [{0, 0}, {0, 3}, {3, 3}, {3, 0}, {0, 0}],
        [{1, 1}, {1, 2}, {2, 2}, {2, 1}, {1, 1}]
      ]
    }

    assert GeoMeasure.area(geom) == 8.0
  end

  test "calculate_polygonz_area_hole" do
    geom = %Geo.PolygonZ{
      coordinates: [
        [{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {4, 0, 3}, {0, 0, 0}],
        [{0, 0, 0}, {0, 1, 0}, {4, 1, 3}, {4, 0, 3}, {0, 0, 0}]
      ]
    }

    assert GeoMeasure.area(geom) == 20.0
  end

  test "calculate_multipolygon_area_holes" do
    geom = %Geo.MultiPolygon{
      coordinates: [
        [
          [{0, 0}, {0, 3}, {3, 3}, {3, 0}, {0, 0}],
          [{1, 1}, {1, 2}, {2, 2}, {2, 1}, {1, 1}]
        ],
        [
          [{4, 4}, {4, 7}, {7, 7}, {7, 4}, {4, 4}],
          [{5, 5}, {5, 6}, {6, 6}, {6, 5}, {5, 5}]
        ]
      ]
    }

    assert GeoMeasure.area(geom) == 16.0
  end

  test "calculate_multipolygonz_area_holes" do
    geom = %Geo.MultiPolygonZ{
      coordinates: [
        [
          [{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {4, 0, 3}, {0, 0, 0}],
          [{0, 0, 0}, {0, 1, 0}, {4, 1, 3}, {4, 0, 3}, {0, 0, 0}]
        ],
        [
          [{5, 5, 1}, {5, 10, 1}, {9, 10, 4}, {9, 5, 4}, {5, 5, 1}],
          [{5, 5, 1}, {5, 6, 1}, {9, 6, 4}, {9, 5, 4}, {5, 5, 1}]
        ]
      ]
    }

    assert GeoMeasure.area(geom) == 40.0
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

  test "calculate_multipoint_bbox" do
    geom = %Geo.MultiPoint{coordinates: [{1, 2}, {3, 4}]}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{1, 2}, {1, 4}, {3, 4}, {3, 2}, {1, 2}]]
           }
  end

  test "calculate_multipointz_bbox" do
    geom = %Geo.MultiPointZ{coordinates: [{0, 0, 0}, {1, 1, 1}]}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 1}, {1, 1}, {1, 0}, {0, 0}]],
             properties: %{min_z: 0, max_z: 1}
           }
  end

  test "calculate_linestring_bbox" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{1, 2}, {1, 4}, {3, 4}, {3, 2}, {1, 2}]]
           }
  end

  test "calculate_linestringm_bbox" do
    geom = %Geo.LineStringM{coordinates: [{1, 2, 5}, {3, 4, 6}]}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{1, 2}, {1, 4}, {3, 4}, {3, 2}, {1, 2}]]
           }
  end

  test "calculate_linestringz_bbox" do
    geom = %Geo.LineStringZ{coordinates: [{0, 0, 0}, {1, 1, 1}]}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 1}, {1, 1}, {1, 0}, {0, 0}]],
             properties: %{min_z: 0, max_z: 1}
           }
  end

  test "calculate_linestringzm_bbox" do
    geom = %Geo.LineStringZM{coordinates: [{0, 0, 0, 2}, {1, 1, 1, 3}]}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 1}, {1, 1}, {1, 0}, {0, 0}]],
             properties: %{min_z: 0, max_z: 1}
           }
  end

  test "calculate_multilinestring_bbox" do
    geom = %Geo.MultiLineString{coordinates: [[{1, 2}, {3, 4}], [{0, 0}, {2, 2}]]}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 4}, {3, 4}, {3, 0}, {0, 0}]]
           }
  end

  test "calculate_multilinestringz_bbox" do
    geom = %Geo.MultiLineStringZ{coordinates: [[{0, 0, 0}, {1, 1, 1}], [{2, 2, 2}, {3, 3, 3}]]}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 3}, {3, 3}, {3, 0}, {0, 0}]],
             properties: %{min_z: 0, max_z: 3}
           }
  end

  test "calculate_polygon_bbox" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]
           }
  end

  test "calculate_polygonz_bbox" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]]}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]],
             properties: %{min_z: 0, max_z: 2}
           }
  end

  test "calculate_multipolygon_bbox" do
    geom = %Geo.MultiPolygon{coordinates: [[[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]], [[{3, 3}, {3, 5}, {5, 5}, {5, 3}, {3, 3}]]]}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 5}, {5, 5}, {5, 0}, {0, 0}]]
           }
  end

  test "calculate_multipolygonz_bbox" do
    geom = %Geo.MultiPolygonZ{coordinates: [[[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]], [[{3, 3, 3}, {3, 5, 4}, {5, 5, 5}, {5, 3, 4}, {3, 3, 3}]]]}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 5}, {5, 5}, {5, 0}, {0, 0}]],
             properties: %{min_z: 0, max_z: 5}
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

  test "calculate_multipoint_bbox_nil_coord" do
    geom = %Geo.MultiPoint{coordinates: [{1, 2}, {3, nil}]}
    assert_raise ArgumentError, fn -> GeoMeasure.bbox(geom) end
  end

  test "calculate_multipointz_bbox_nil_coord" do
    geom = %Geo.MultiPointZ{coordinates: [{0, 0, 0}, {1, nil, 1}]}
    assert_raise ArgumentError, fn -> GeoMeasure.bbox(geom) end
  end

  test "calculate_linestring_bbox_nil_coord" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {nil, 4}]}
    assert_raise ArgumentError, fn -> GeoMeasure.bbox(geom) end
  end

  test "calculate_linestringm_bbox_nil_coord" do
    geom = %Geo.LineStringM{coordinates: [{1, 2, 5}, {nil, 4, 5}]}
    assert_raise ArgumentError, fn -> GeoMeasure.bbox(geom) end
  end

  test "calculate_linestringz_bbox_nil_coord" do
    geom = %Geo.LineStringZ{coordinates: [{0, nil, 0}, {1, 1, 1}]}
    assert_raise ArgumentError, fn -> GeoMeasure.bbox(geom) end
  end

  test "calculate_linestringzm_bbox_nil_coord" do
    geom = %Geo.LineStringZM{coordinates: [{0, 0, 0, 2}, {1, nil, 1, 3}]}
    assert_raise ArgumentError, fn -> GeoMeasure.bbox(geom) end
  end

  test "calculate_multilinestring_bbox_nil_coord" do
    geom = %Geo.MultiLineString{coordinates: [[{1, 2}, {3, 4}], [{nil, 0}, {2, 2}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.bbox(geom) end
  end

  test "calculate_multilinestringz_bbox_nil_coord" do
    geom = %Geo.MultiLineStringZ{coordinates: [[{0, 0, 0}, {1, 1, 1}], [{2, nil, 2}, {3, 3, 3}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.bbox(geom) end
  end

  test "calculate_polygon_bbox_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, nil}, {2, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.bbox(geom) end
  end

  test "calculate_polygonz_bbox_nil_coord" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, nil, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.bbox(geom) end
  end

  test "calculate_multipolygon_bbox_nil_coord" do
    geom = %Geo.MultiPolygon{coordinates: [[[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]], [[{3, 3}, {nil, 5}, {5, 5}, {5, 3}, {3, 3}]]]}
    assert_raise ArgumentError, fn -> GeoMeasure.bbox(geom) end
  end

  test "calculate_multipolygonz_bbox_nil_coord" do
    geom = %Geo.MultiPolygonZ{coordinates: [[[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]], [[{3, 3, 3}, {3, nil, 4}, {5, 5, 5}, {5, 3, 4}, {3, 3, 3}]]]}
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

  test "calculate_multipoint_bbox_with_srid" do
    geom = %Geo.MultiPoint{coordinates: [{1, 2}, {3, 4}], srid: 27700}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{1, 2}, {1, 4}, {3, 4}, {3, 2}, {1, 2}]],
             srid: 27700
           }
  end

  test "calculate_multipointz_bbox_with_srid" do
    geom = %Geo.MultiPointZ{coordinates: [{0, 0, 0}, {1, 1, 1}], srid: 23700}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 1}, {1, 1}, {1, 0}, {0, 0}]],
             srid: 23700,
             properties: %{min_z: 0, max_z: 1}
           }
  end

  test "calculate_linestring_bbox_with_srid" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}], srid: 27700}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{1, 2}, {1, 4}, {3, 4}, {3, 2}, {1, 2}]],
             srid: 27700
           }
  end

  test "calculate_linestringm_bbox_with_srid" do
    geom = %Geo.LineStringM{coordinates: [{1, 2, 5}, {3, 4, 5}], srid: 27700}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{1, 2}, {1, 4}, {3, 4}, {3, 2}, {1, 2}]],
             srid: 27700
           }
  end

  test "calculate_linestringz_bbox_with_srid" do
    geom = %Geo.LineStringZ{coordinates: [{0, 0, 0}, {1, 1, 1}], srid: 23700}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 1}, {1, 1}, {1, 0}, {0, 0}]],
             srid: 23700,
             properties: %{min_z: 0, max_z: 1}
           }
  end

  test "calculate_linestringzm_bbox_with_srid" do
    geom = %Geo.LineStringZM{coordinates: [{0, 0, 0, 2}, {1, 1, 1, 3}], srid: 23700}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 1}, {1, 1}, {1, 0}, {0, 0}]],
             srid: 23700,
             properties: %{min_z: 0, max_z: 1}
           }
  end

  test "calculate_multilinestring_bbox_with_srid" do
    geom = %Geo.MultiLineString{coordinates: [[{1, 2}, {3, 4}], [{0, 0}, {2, 2}]], srid: 27700}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 4}, {3, 4}, {3, 0}, {0, 0}]],
             srid: 27700
           }
  end

  test "calculate_multilinestringz_bbox_with_srid" do
    geom = %Geo.MultiLineStringZ{coordinates: [[{0, 0, 0}, {1, 1, 1}], [{2, 2, 2}, {3, 3, 3}]], srid: 23700}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 3}, {3, 3}, {3, 0}, {0, 0}]],
             srid: 23700,
             properties: %{min_z: 0, max_z: 3}
           }
  end

  test "calculate_polygon_bbox_with_srid" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]], srid: 27700}

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]],
             srid: 27700
           }
  end

  test "calculate_polygonz_bbox_with_srid" do
    geom = %Geo.PolygonZ{
      coordinates: [[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]],
      srid: 23700
    }

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]],
             srid: 23700,
             properties: %{min_z: 0, max_z: 2}
           }
  end

  test "calculate_multipolygon_bbox_with_srid" do
    geom = %Geo.MultiPolygon{
      coordinates: [
        [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]],
        [[{3, 3}, {3, 5}, {5, 5}, {5, 3}, {3, 3}]]
      ],
      srid: 27700
    }

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 5}, {5, 5}, {5, 0}, {0, 0}]],
             srid: 27700
           }
  end

  test "calculate_multipolygonz_bbox_with_srid" do
    geom = %Geo.MultiPolygonZ{
      coordinates: [
        [[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]],
        [[{3, 3, 3}, {3, 5, 4}, {5, 5, 5}, {5, 3, 4}, {3, 3, 3}]]
      ],
      srid: 23700
    }

    assert GeoMeasure.bbox(geom) == %Geo.Polygon{
             coordinates: [[{0, 0}, {0, 5}, {5, 5}, {5, 0}, {0, 0}]],
             srid: 23700,
             properties: %{min_z: 0, max_z: 5}
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

  test "calculate_multipoint_centroid" do
    geom = %Geo.MultiPoint{coordinates: [{1, 2}, {3, 4}, {5, 6}]}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {3.0, 4.0}}
  end

  test "calculate_multipointz_centroid" do
    geom = %Geo.MultiPointZ{coordinates: [{1, 2, 3}, {3, 4, 5}, {5, 6, 7}]}
    assert GeoMeasure.centroid(geom) == %Geo.PointZ{coordinates: {3.0, 4.0, 5.0}}
  end

  test "calculate_linestring_centroid" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {2.0, 3.0}}
  end

  test "calculate_linestringm_centroid" do
    geom = %Geo.LineStringM{coordinates: [{1, 2, 5}, {3, 4, 5}]}
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

  test "calculate_multilinestring_centroid" do
    geom = %Geo.MultiLineString{coordinates: [[{1, 2}, {3, 4}], [{5, 6}, {7, 8}]]}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {4.0, 5.0}}
  end

  test "calculate_multilinestringz_centroid" do
    geom = %Geo.MultiLineStringZ{coordinates: [[{1, 2, 3}, {3, 4, 5}], [{5, 6, 7}, {7, 8, 9}]]}
    assert GeoMeasure.centroid(geom) == %Geo.PointZ{coordinates: {4.0, 5.0, 6.0}}
  end

  test "calculate_polygon_centroid" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {1.0, 1.0}}
  end

  test "calculate_polygonz_centroid" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]]}
    assert GeoMeasure.centroid(geom) == %Geo.PointZ{coordinates: {1.0, 1.0, 1.0}}
  end

  test "calculate_multipolygon_centroid" do
    geom = %Geo.MultiPolygon{
      coordinates: [
        [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]],
        [[{2, 2}, {2, 4}, {4, 4}, {4, 2}, {2, 2}]]
      ]
    }

    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {2.0, 2.0}}
  end

  test "calculate_multipolygonz_centroid" do
    geom = %Geo.MultiPolygonZ{
      coordinates: [
        [[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]],
        [[{2, 2, 2}, {2, 4, 3}, {4, 4, 4}, {4, 2, 3}, {2, 2, 2}]]
      ]
    }

    assert GeoMeasure.centroid(geom) == %Geo.PointZ{coordinates: {2.0, 2.0, 2.0}}
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

  test "calculate_multipoint_centroid_nil_coord" do
    geom = %Geo.MultiPoint{coordinates: [{1, 2}, {nil, 4}, {5, 6}]}
    assert_raise ArgumentError, fn -> GeoMeasure.centroid(geom) end
  end

  test "calculate_multipointz_centroid_nil_coord" do
    geom = %Geo.MultiPointZ{coordinates: [{1, 2, 3}, {nil, 4, 5}, {5, 6, 7}]}
    assert_raise ArgumentError, fn -> GeoMeasure.centroid(geom) end
  end

  test "calculate_linestring_centroid_nil_coord" do
    geom = %Geo.LineString{coordinates: [{1, nil}, {3, 4}]}
    assert_raise ArgumentError, fn -> GeoMeasure.centroid(geom) end
  end

  test "calculate_linestringm_centroid_nil_coord" do
    geom = %Geo.LineStringM{coordinates: [{1, nil, 5}, {3, 4, 5}]}
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

  test "calculate_multilinestring_centroid_nil_coord" do
    geom = %Geo.MultiLineString{coordinates: [[{1, 2}, {nil, 4}], [{5, 6}, {7, 8}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.centroid(geom) end
  end

  test "calculate_multilinestringz_centroid_nil_coord" do
    geom = %Geo.MultiLineStringZ{coordinates: [[{1, 2, 3}, {nil, 4, 5}], [{5, 6, 7}, {7, 8, 9}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.centroid(geom) end
  end

  test "calculate_polygon_centroid_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {nil, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.centroid(geom) end
  end

  test "calculate_polygonz_centroid_nil_coord" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, nil, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.centroid(geom) end
  end

  test "calculate_multipolygon_centroid_nil_coord" do
    geom = %Geo.MultiPolygon{
      coordinates: [
        [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]],
        [[{2, 2}, {2, 4}, {nil, 4}, {4, 2}, {2, 2}]]
      ]
    }

    assert_raise ArgumentError, fn -> GeoMeasure.centroid(geom) end
  end

  test "calculate_multipolygonz_centroid_nil_coord" do
    geom = %Geo.MultiPolygonZ{
      coordinates: [
        [[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]],
        [[{2, 2, 2}, {2, 4, 3}, {nil, 4, 4}, {4, 2, 3}, {2, 2, 2}]]
      ]
    }

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

  test "calculate_multipoint_centroid_with_srid" do
    geom = %Geo.MultiPoint{coordinates: [{1, 2}, {3, 4}, {5, 6}], srid: 23700}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {3.0, 4.0}, srid: 23700}
  end

  test "calculate_multipointz_centroid_with_srid" do
    geom = %Geo.MultiPointZ{coordinates: [{1, 2, 3}, {3, 4, 5}, {5, 6, 7}], srid: 23700}
    assert GeoMeasure.centroid(geom) == %Geo.PointZ{coordinates: {3.0, 4.0, 5.0}, srid: 23700}
  end

  test "calculate_linestring_centroid_with_srid" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}], srid: 23700}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {2.0, 3.0}, srid: 23700}
  end

  test "calculate_linestringm_centroid_with_srid" do
    geom = %Geo.LineStringM{coordinates: [{1, 2, 5}, {3, 4, 5}], srid: 23700}
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

  test "calculate_multilinestring_centroid_with_srid" do
    geom = %Geo.MultiLineString{coordinates: [[{1, 2}, {3, 4}], [{5, 6}, {7, 8}]], srid: 23700}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {4.0, 5.0}, srid: 23700}
  end

  test "calculate_multilinestringz_centroid_with_srid" do
    geom = %Geo.MultiLineStringZ{coordinates: [[{1, 2, 3}, {3, 4, 5}], [{5, 6, 7}, {7, 8, 9}]], srid: 23700}
    assert GeoMeasure.centroid(geom) == %Geo.PointZ{coordinates: {4.0, 5.0, 6.0}, srid: 23700}
  end

  test "calculate_polygon_centroid_with_srid" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]], srid: 23700}
    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {1.0, 1.0}, srid: 23700}
  end

  test "calculate_polygonz_centroid_with_srid" do
    geom = %Geo.PolygonZ{
      coordinates: [[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]],
      srid: 23700
    }

    assert GeoMeasure.centroid(geom) == %Geo.PointZ{coordinates: {1.0, 1.0, 1.0}, srid: 23700}
  end

  test "calculate_multipolygon_centroid_with_srid" do
    geom = %Geo.MultiPolygon{
      coordinates: [
        [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]],
        [[{2, 2}, {2, 4}, {4, 4}, {4, 2}, {2, 2}]]
      ],
      srid: 23700
    }

    assert GeoMeasure.centroid(geom) == %Geo.Point{coordinates: {2.0, 2.0}, srid: 23700}
  end

  test "calculate_multipolygonz_centroid_with_srid" do
    geom = %Geo.MultiPolygonZ{
      coordinates: [
        [[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]],
        [[{2, 2, 2}, {2, 4, 3}, {4, 4, 4}, {4, 2, 3}, {2, 2, 2}]]
      ],
      srid: 23700
    }

    assert GeoMeasure.centroid(geom) == %Geo.PointZ{coordinates: {2.0, 2.0, 2.0}, srid: 23700}
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

  test "calculate_linestringm_extent" do
    geom = %Geo.LineStringM{coordinates: [{1, 2, 5}, {3, 4, 5}]}
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

  test "calculate_multilinestring_extent" do
    geom = %Geo.MultiLineString{coordinates: [[{1, 2}, {3, 4}], [{0, -1}, {2, 3}]]}
    assert GeoMeasure.extent(geom) == {0, 3, -1, 4}
  end

  test "calculate_multilinestringz_extent" do
    geom = %Geo.MultiLineStringZ{coordinates: [[{1, 2, 3}, {3, 4, 5}], [{0, -1, 2}, {2, 3, 4}]]}
    assert GeoMeasure.extent(geom) == {0, 3, -1, 4, 2, 5}
  end

  test "calculate_polygon_extent" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoMeasure.extent(geom) == {0, 2, 0, 2}
  end

  test "calculate_polygonz_extent" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]]}
    assert GeoMeasure.extent(geom) == {0, 2, 0, 2, 0, 2}
  end

  test "calculate_multipolygon_extent" do
    geom = %Geo.MultiPolygon{coordinates: [[[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]], [[{1, 1}, {1, 3}, {3, 3}, {3, 1}, {1, 1}]]]}
    assert GeoMeasure.extent(geom) == {0, 3, 0, 3}
  end

  test "calculate_multipolygonz_extent" do
    geom = %Geo.MultiPolygonZ{coordinates: [[[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]], [[{1, 1, 1}, {1, 3, 2}, {3, 3, 3}, {3, 1, 2}, {1, 1, 1}]]]}
    assert GeoMeasure.extent(geom) == {0, 3, 0, 3, 0, 3}
  end

  test "calculate_multipoint_extent" do
    geom = %Geo.MultiPoint{coordinates: [{1, 2}, {3, 4}, {0, -1}]}
    assert GeoMeasure.extent(geom) == {0, 3, -1, 4}
  end

  test "calculate_multipointz_extent" do
    geom = %Geo.MultiPointZ{coordinates: [{1, 2, 3}, {3, 4, 5}, {0, -1, 2}]}
    assert GeoMeasure.extent(geom) == {0, 3, -1, 4, 2, 5}
  end

  test "calculate_multipoint_extent_nil_coord" do
    geom = %Geo.MultiPoint{coordinates: [{1, 2}, {nil, 4}, {0, -1}]}
    assert_raise ArgumentError, fn -> GeoMeasure.extent(geom) end
  end

  test "calculate_multipointz_extent_nil_coord" do
    geom = %Geo.MultiPointZ{coordinates: [{1, 2, 3}, {nil, 4, 5}, {0, -1, 2}]}
    assert_raise ArgumentError, fn -> GeoMeasure.extent(geom) end
  end

  test "calculate_linestring_extent_nil_coord" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {nil, 4}]}
    assert_raise ArgumentError, fn -> GeoMeasure.extent(geom) end
  end

  test "calculate_linestringm_extent_nil_coord" do
    geom = %Geo.LineStringM{coordinates: [{1, 2, 5}, {nil, 4, 5}]}
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

  test "calculate_multilinestring_extent_nil_coord" do
    geom = %Geo.MultiLineString{coordinates: [[{1, 2}, {nil, 4}], [{0, -1}, {2, 3}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.extent(geom) end
  end

  test "calculate_multilinestringz_extent_nil_coord" do
    geom = %Geo.MultiLineStringZ{coordinates: [[{1, 2, 3}, {nil, 4, 5}], [{0, -1, 2}, {2, 3, 4}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.extent(geom) end
  end

  test "calculate_polygon_extent_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {nil, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.extent(geom) end
  end

  test "calculate_polygonz_extent_nil_coord" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, nil, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.extent(geom) end
  end

  test "calculate_multipolygon_extent_nil_coord" do
    geom = %Geo.MultiPolygon{coordinates: [[[{0, 0}, {0, 2}, {nil, 2}, {2, 0}, {0, 0}]], [[{1, 1}, {1, 3}, {3, 3}, {3, 1}, {1, 1}]]]}
    assert_raise ArgumentError, fn -> GeoMeasure.extent(geom) end
  end

  test "calculate_multipolygonz_extent_nil_coord" do
    geom = %Geo.MultiPolygonZ{coordinates: [[[{0, 0, 0}, {0, 2, 1}, {nil, 2, 2}, {2, 0, 1}, {0, 0, 0}]], [[{1, 1, 1}, {1, 3, 2}, {3, 3, 3}, {3, 1, 2}, {1, 1, 1}]]]}
    assert_raise ArgumentError, fn -> GeoMeasure.extent(geom) end
  end

  test "calculate_polygonz_footprint_area" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {4, 0, 3}, {0, 0, 0}]]}
    assert GeoMeasure.footprint_area(geom) == 20.0
  end

  test "calculate_polygonz_footprint_area_nil_coord" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {nil, 0, 3}, {0, 0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.footprint_area(geom) end
  end

  test "calculate_polygonz_footprint_area_hole" do
    geom = %Geo.PolygonZ{
      coordinates: [
        [{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {4, 0, 3}, {0, 0, 0}],
        [{0, 0, 0}, {0, 1, 0}, {4, 1, 3}, {4, 0, 3}, {0, 0, 0}]
      ]
    }

    assert GeoMeasure.footprint_area(geom) == 16.0
  end

  test "calculate_multipolygonz_footprint_area" do
    geom = %Geo.MultiPolygonZ{
      coordinates: [
        [[{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {4, 0, 3}, {0, 0, 0}]],
        [[{10, 10, 0}, {10, 15, 0}, {14, 15, 3}, {14, 10, 3}, {10, 10, 0}]]
      ]
    }

    assert GeoMeasure.footprint_area(geom) == 40.0
  end

  test "calculate_multipolygonz_footprint_area_nil_coord" do
    geom = %Geo.MultiPolygonZ{
      coordinates: [
        [[{0, 0, 0}, {0, nil, 0}, {4, 5, 3}, {4, 0, 3}, {0, 0, 0}]],
        [[{10, 10, 0}, {10, 15, 0}, {14, 15, 3}, {14, 10, 3}, {10, 10, 0}]]
      ]
    }

    assert_raise ArgumentError, fn -> GeoMeasure.footprint_area(geom) end
  end

  test "calculate_multipolygonz_footprint_area_hole" do
    geom = %Geo.MultiPolygonZ{
      coordinates: [
        [[{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {4, 0, 3}, {0, 0, 0}]],
        [
          [{10, 10, 0}, {10, 15, 0}, {14, 15, 3}, {14, 10, 3}, {10, 10, 0}],
          [{12, 12, 0}, {12, 13, 0}, {13, 13, 3}, {13, 12, 3}, {12, 12, 0}]
        ]
      ]
    }

    assert GeoMeasure.footprint_area(geom) == 39.0
  end

  test "calculate_linestringz_footprint_length" do
    geom = %Geo.LineStringZ{coordinates: [{1, 2, 2}, {1, 4, 2}]}
    assert GeoMeasure.footprint_length(geom) == 2.0
  end

  test "calculate_linestringzm_footprint_length" do
    geom = %Geo.LineStringZM{coordinates: [{1, 2, 2, 10}, {1, 4, 2, 11}]}
    assert GeoMeasure.footprint_length(geom) == 2.0
  end

  test "calculate_multilinestringz_footprint_length" do
    geom = %Geo.MultiLineStringZ{
      coordinates: [
        [{0, 0, 0}, {0, 3, 0}],
        [{0, 0, 0}, {4, 0, 0}]
      ]
    }

    assert GeoMeasure.footprint_length(geom) == 7.0
  end

  test "calculate_linestringz_footprint_length_nil_coord" do
    geom = %Geo.LineStringZ{coordinates: [{1, 2, 2}, {1, nil, 2}]}
    assert_raise ArgumentError, fn -> GeoMeasure.footprint_length(geom) end
  end

  test "calculate_linestringzm_footprint_length_nil_coord" do
    geom = %Geo.LineStringZM{coordinates: [{nil, 2, 2, 10}, {1, 4, 2, 11}]}
    assert_raise ArgumentError, fn -> GeoMeasure.footprint_length(geom) end
  end

  test "calculate_multilinestringz_footprint_length_nil_coord" do
    geom = %Geo.MultiLineStringZ{
      coordinates: [
        [{0, 0, 0}, {nil, 3, 0}],
        [{0, 0, 0}, {4, 0, 0}]
      ]
    }

    assert_raise ArgumentError, fn -> GeoMeasure.footprint_length(geom) end
  end

  test "calculate_polygonz_footprint_perimeter" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]]}
    assert GeoMeasure.footprint_perimeter(geom) == 8.0
  end

  test "calculate_multipolygonz_footprint_perimeter" do
    geom = %Geo.MultiPolygonZ{
      coordinates: [
        [[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]],
        [[{3, 3, 0}, {3, 5, 1}, {5, 5, 2}, {5, 3, 1}, {3, 3, 0}]]
      ]
    }

    assert GeoMeasure.footprint_perimeter(geom) == 16.0
  end

  test "calculate_polygonz_footprint_perimeter_hole" do
    geom = %Geo.PolygonZ{
      coordinates: [
        [{0, 0, 0}, {0, 3, 1}, {3, 3, 2}, {3, 0, 1}, {0, 0, 0}],
        [{1, 1, 0.66}, {1, 2, 1}, {2, 2, 1.33}, {2, 1, 1}, {1, 1, 0.66}]
      ]
    }

    assert GeoMeasure.footprint_perimeter(geom) == 16.0
  end

  test "calculate_multipolygonz_footprint_perimeter_hole" do
    geom = %Geo.MultiPolygonZ{
      coordinates: [
        [[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]],
        [
          [{3, 3, 0}, {3, 5, 1}, {5, 5, 2}, {5, 3, 1}, {3, 3, 0}],
          [{4, 4, 0}, {4, 4.5, 1}, {4.5, 4.5, 2}, {4.5, 4, 1}, {4, 4, 0}]
        ]
      ]
    }

    assert GeoMeasure.footprint_perimeter(geom) == 18.0
  end

  test "calculate_polygonz_footprint_perimeter_nil_coord" do
    geom = %Geo.PolygonZ{
      coordinates: [[{0, 0, 0}, {nil, 2, 0}, {2, nil, 0}, {2, 0, 0}, {0, 0, 0}]]
    }

    assert_raise ArgumentError, fn -> GeoMeasure.footprint_perimeter(geom) end
  end

  test "calculate_multipolygonz_footprint_perimeter_nil_coord" do
    geom = %Geo.MultiPolygonZ{
      coordinates: [
        [[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]],
        [[{3, 3, 0}, {3, 5, 1}, {5, 5, 2}, {5, nil, 1}, {3, 3, 0}]]
      ]
    }

    assert_raise ArgumentError, fn -> GeoMeasure.footprint_perimeter(geom) end
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

  test "calculate_multipoint_perimeter" do
    geom = %Geo.MultiPoint{coordinates: [{1, 2}, {3, 4}]}
    assert_raise FunctionClauseError, fn -> GeoMeasure.perimeter(geom) end
  end

  test "calculate_multipointz_perimeter" do
    geom = %Geo.MultiPointZ{coordinates: [{1, 2, 0}, {3, 4, 0}]}
    assert_raise FunctionClauseError, fn -> GeoMeasure.perimeter(geom) end
  end

  test "calculate_linestring_length" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {1, 4}]}
    assert GeoMeasure.length(geom) == 2.0
  end

  test "calculate_linestringm_length" do
    geom = %Geo.LineStringM{coordinates: [{1, 2, 5}, {1, 4, 5}]}
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

  test "calculate_multilinestring_length" do
    geom = %Geo.MultiLineString{coordinates: [[{1, 2}, {1, 4}], [{2, 2}, {2, 5}]]}
    assert GeoMeasure.perimeter(geom) == 5.0
  end

  test "calculate_multilinestringz_length" do
    geom = %Geo.MultiLineStringZ{coordinates: [[{1, 2, 0}, {1, 4, 0}], [{2, 2, 0}, {2, 5, 0}]]}
    assert GeoMeasure.perimeter(geom) == 5.0
  end

  test "calculate_polygon_perimeter" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoMeasure.perimeter(geom) == 8.0
  end

  test "calculate_polygon_perimeter_hole" do
    geom = %Geo.Polygon{
      coordinates: [
        [{0, 0}, {0, 3}, {3, 3}, {3, 0}, {0, 0}],
        [{1, 1}, {1, 2}, {2, 2}, {2, 1}, {1, 1}]
      ]
    }

    assert GeoMeasure.perimeter(geom) == 16.0
  end

  test "calculate_polygonz_perimeter" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]]}
    assert GeoMeasure.perimeter(geom) == 8.94427190999916
  end

  test "calculate_polygonz_perimeter_hole" do
    geom = %Geo.PolygonZ{
      coordinates: [
        [{0, 0, 0}, {0, 3, 1}, {3, 3, 2}, {3, 0, 1}, {0, 0, 0}],
        [{1, 1, 0.66}, {1, 2, 1}, {2, 2, 1.33}, {2, 1, 1}, {1, 1, 0.66}]
      ]
    }

    assert GeoMeasure.perimeter(geom) == 16.8676364068953
  end

  test "calculate_multipolygon_perimeter" do
    geom = %Geo.MultiPolygon{
      coordinates: [
        [
          [{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]
        ],
        [
          [{3, 3}, {3, 5}, {5, 5}, {5, 3}, {3, 3}]
        ]
      ]
    }

    assert GeoMeasure.perimeter(geom) == 16.0
  end

  test "calculate_multipolygonz_perimeter" do
    geom = %Geo.MultiPolygonZ{
      coordinates: [
        [
          [{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]
        ],
        [
          [{3, 3, 0}, {3, 5, 1}, {5, 5, 2}, {5, 3, 1}, {3, 3, 0}]
        ]
      ]
    }

    assert GeoMeasure.perimeter(geom) == 17.88854381999832
  end

  test "calculate_linestring_length_nil_coord" do
    geom = %Geo.LineString{coordinates: [{1, nil}, {1, 4}]}
    assert_raise ArgumentError, fn -> GeoMeasure.length(geom) end
  end

  test "calculate_linestringm_length_nil_coord" do
    geom = %Geo.LineStringM{coordinates: [{1, nil, 5}, {1, 4, 5}]}
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

  test "calculate_multilinestring_length_nil_coord" do
    geom = %Geo.MultiLineString{coordinates: [[{1, 2}, {1, nil}], [{2, 2}, {2, 5}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.length(geom) end
  end

  test "calculate_multilinestringz_length_nil_coord" do
    geom = %Geo.MultiLineStringZ{coordinates: [[{1, 2, 0}, {1, nil, 0}], [{2, 2, 0}, {2, 5, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.length(geom) end
  end

  test "calculate_polygon_perimeter_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {nil, 2}, {2, nil}, {2, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.perimeter(geom) end
  end

  test "calculate_polygonz_perimeter_nil_coord" do
    geom = %Geo.PolygonZ{
      coordinates: [[{0, 0, 0}, {nil, 2, 0}, {2, nil, 0}, {2, 0, 0}, {0, 0, 0}]]
    }

    assert_raise ArgumentError, fn -> GeoMeasure.perimeter(geom) end
  end

  test "calculate_multipolygon_perimeter_nil_coord" do
    geom = %Geo.MultiPolygon{
      coordinates: [
        [
          [{0, 0}, {0, 2}, {2, nil}, {2, 0}, {0, 0}]
        ],
        [
          [{3, 3}, {3, 5}, {5, 5}, {5, 3}, {3, 3}]
        ]
      ]
    }

    assert_raise ArgumentError, fn -> GeoMeasure.perimeter(geom) end
  end

  test "calculate_multipolygonz_perimeter_nil_coord" do
    geom = %Geo.MultiPolygonZ{
      coordinates: [
        [
          [{0, 0, 0}, {0, 2, 1}, {2, nil, 2}, {2, 0, 1}, {0, 0, 0}]
        ],
        [
          [{3, 3, 0}, {3, 5, 1}, {5, 5, 2}, {5, 3, 1}, {3, 3, 0}]
        ]
      ]
    }

    assert_raise ArgumentError, fn -> GeoMeasure.perimeter(geom) end
  end
end
