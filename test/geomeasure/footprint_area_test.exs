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
end
