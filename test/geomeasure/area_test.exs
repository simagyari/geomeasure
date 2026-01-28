defmodule GeoMeasure.Area.Test do
  use ExUnit.Case, async: true

  test "calculate_point_area" do
    geom = %Geo.Point{coordinates: {1, 2}}
    assert_raise FunctionClauseError, fn -> GeoMeasure.Area.calculate(geom) end
  end

  test "calculate_linestring_area" do
    geom = %Geo.LineString{coordinates: [{1, 2}, {3, 4}]}
    assert_raise FunctionClauseError, fn -> GeoMeasure.Area.calculate(geom) end
  end

  test "calculate_polygon_area" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}
    assert GeoMeasure.Area.calculate(geom) == 4.0
  end

  test "calculate_polygonz_area" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {4, 0, 3}, {0, 0, 0}]]}
    assert GeoMeasure.Area.calculate(geom) == 25.0
  end

  test "calculate_multipolygon_area" do
    geom = %Geo.MultiPolygon{
      coordinates: [
        [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]],
        [[{1, 1}, {1, 3}, {3, 3}, {3, 1}, {1, 1}]]
      ]
    }

    assert GeoMeasure.Area.calculate(geom) == 8.0
  end

  test "calculate_multipolygonz_area" do
    geom = %Geo.MultiPolygonZ{
      coordinates: [
        [[{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {4, 0, 3}, {0, 0, 0}]],
        [[{1, 1, 1}, {1, 6, 1}, {5, 6, 4}, {5, 1, 4}, {1, 1, 1}]]
      ]
    }

    assert GeoMeasure.Area.calculate(geom) == 50.0
  end

  test "calculate_polygon_area_nil_coord" do
    geom = %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {nil, 0}, {0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.Area.calculate(geom) end
  end

  test "calculate_polygonz_area_nil_coord" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {nil, 0, 3}, {0, 0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.Area.calculate(geom) end
  end

  test "calculate_multipolygon_area_nil_coord" do
    geom = %Geo.MultiPolygon{
      coordinates: [
        [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]],
        [[{1, 1}, {1, nil}, {3, 3}, {3, 1}, {1, 1}]]
      ]
    }

    assert_raise ArgumentError, fn -> GeoMeasure.Area.calculate(geom) end
  end

  test "calculate_multipolygonz_area_nil_coord" do
    geom = %Geo.MultiPolygonZ{
      coordinates: [
        [[{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {4, 0, 3}, {0, 0, 0}]],
        [[{1, 1, 1}, {1, 6, nil}, {5, 6, 4}, {5, 1, 4}, {1, 1, 1}]]
      ]
    }

    assert_raise ArgumentError, fn -> GeoMeasure.Area.calculate(geom) end
  end

  test "calculate_polygon_area_hole" do
    geom = %Geo.Polygon{
      coordinates: [
        [{0, 0}, {0, 3}, {3, 3}, {3, 0}, {0, 0}],
        [{1, 1}, {1, 2}, {2, 2}, {2, 1}, {1, 1}]
      ]
    }

    assert GeoMeasure.Area.calculate(geom) == 8.0
  end

  test "calculate_polygonz_area_hole" do
    geom = %Geo.PolygonZ{
      coordinates: [
        [{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {4, 0, 3}, {0, 0, 0}],
        [{0, 0, 0}, {0, 1, 0}, {4, 1, 3}, {4, 0, 3}, {0, 0, 0}]
      ]
    }

    assert GeoMeasure.Area.calculate(geom) == 20.0
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

    assert GeoMeasure.Area.calculate(geom) == 16.0
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

    assert GeoMeasure.Area.calculate(geom) == 40.0
  end
end
