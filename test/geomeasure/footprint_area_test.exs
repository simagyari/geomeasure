defmodule GeoMeasure.FootprintArea.Test do
  use ExUnit.Case, async: true

  test "calculate_polygonz_footprint_area" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {4, 0, 3}, {0, 0, 0}]]}
    assert GeoMeasure.FootprintArea.calculate(geom) == 20.0
  end

  test "calculate_polygonz_footprint_area_nil_coord" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {nil, 0, 3}, {0, 0, 0}]]}
    assert_raise ArgumentError, fn -> GeoMeasure.Area.calculate(geom) end
  end

  test "calculate_polygonz_footprint_area_hole" do
    geom = %Geo.PolygonZ{
      coordinates: [
        [{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {4, 0, 3}, {0, 0, 0}],
        [{0, 0, 0}, {0, 1, 0}, {4, 1, 3}, {4, 0, 3}, {0, 0, 0}]
      ]
    }

    assert GeoMeasure.FootprintArea.calculate(geom) == 16.0
  end

  test "calculate_multipolygonz_footprint_area" do
    geom = %Geo.MultiPolygonZ{
      coordinates: [
        [[{0, 0, 0}, {0, 5, 0}, {4, 5, 3}, {4, 0, 3}, {0, 0, 0}]],
        [[{10, 10, 0}, {10, 15, 0}, {14, 15, 3}, {14, 10, 3}, {10, 10, 0}]]
      ]
    }

    assert GeoMeasure.FootprintArea.calculate(geom) == 40.0
  end

  test "calculate_multipolygonz_footprint_area_nil_coord" do
    geom = %Geo.MultiPolygonZ{
      coordinates: [
        [[{0, 0, 0}, {0, nil, 0}, {4, 5, 3}, {4, 0, 3}, {0, 0, 0}]],
        [[{10, 10, 0}, {10, 15, 0}, {14, 15, 3}, {14, 10, 3}, {10, 10, 0}]]
      ]
    }

    assert_raise ArgumentError, fn -> GeoMeasure.FootprintArea.calculate(geom) end
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

    assert GeoMeasure.FootprintArea.calculate(geom) == 39.0
  end
end
