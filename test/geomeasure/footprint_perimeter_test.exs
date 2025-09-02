defmodule GeoMeasure.FootprintPerimeter.Test do
  use ExUnit.Case, async: true


  test "calculate_linestringz_footprint_length" do
    geom = %Geo.LineStringZ{coordinates: [{1, 2, 2}, {1, 4, 2}]}
    assert GeoMeasure.FootprintPerimeter.calculate(geom) == 2.0
  end

  test "calculate_linestringzm_footprint_length" do
    geom = %Geo.LineStringZM{coordinates: [{1, 2, 2, 10}, {1, 4, 2, 11}]}
    assert GeoMeasure.FootprintPerimeter.calculate(geom) == 2.0
  end

  test "calculate_linestringz_footprint_length_nil_coord" do
    geom = %Geo.LineStringZ{coordinates: [{1, 2, 2}, {1, nil, 2}]}
    assert_raise ArgumentError, fn -> GeoMeasure.FootprintPerimeter.calculate(geom) end
  end

  test "calculate_linestringzm_footprint_length_nil_coord" do
    geom = %Geo.LineStringZM{coordinates: [{nil, 2, 2, 10}, {1, 4, 2, 11}]}
    assert_raise ArgumentError, fn -> GeoMeasure.FootprintPerimeter.calculate(geom) end
  end

  test "calculate_polygonz_footprint_perimeter" do
    geom = %Geo.PolygonZ{coordinates: [[{0, 0, 0}, {0, 2, 1}, {2, 2, 2}, {2, 0, 1}, {0, 0, 0}]]}
    assert GeoMeasure.FootprintPerimeter.calculate(geom) == 8.0
  end

  test "calculate_polygonz_footprint_perimeter_hole" do
    geom = %Geo.PolygonZ{
      coordinates: [
        [{0, 0, 0}, {0, 3, 1}, {3, 3, 2}, {3, 0, 1}, {0, 0, 0}],
        [{1, 1, 0.66}, {1, 2, 1}, {2, 2, 1.33}, {2, 1, 1}, {1, 1, 0.66}]
      ]
    }

    assert GeoMeasure.FootprintPerimeter.calculate(geom) == 16.0
  end

  test "calculate_polygonz_footprint_perimeter_nil_coord" do
    geom = %Geo.PolygonZ{
      coordinates: [[{0, 0, 0}, {nil, 2, 0}, {2, nil, 0}, {2, 0, 0}, {0, 0, 0}]]
    }

    assert_raise ArgumentError, fn -> GeoMeasure.FootprintPerimeter.calculate(geom) end
  end
end
