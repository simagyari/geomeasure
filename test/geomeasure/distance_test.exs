defmodule GeoMeasure.Distance.Test do
  use ExUnit.Case, async: true

  test "calculate_distance_x_direction" do
    a = {0, 0}
    b = {5, 0}
    assert GeoMeasure.Distance.calculate(a, b) == 5.0
  end

  test "calculate_distance_y_direction" do
    a = {0, 0}
    b = {0, 5}
    assert GeoMeasure.Distance.calculate(a, b) == 5.0
  end

  test "calculate_distance_xy_direction" do
    a = {0, 0}
    b = {3, 4}
    assert GeoMeasure.Distance.calculate(a, b) == 5.0
  end

  test "calculate_3d_distance_x_direction" do
    a = {0, 0, 0}
    b = {5, 0, 0}
    assert GeoMeasure.Distance.calculate(a, b) == 5.0
  end

  test "calculate_3d_distance_y_direction" do
    a = {0, 0, 0}
    b = {0, 5, 0}
    assert GeoMeasure.Distance.calculate(a, b) == 5.0
  end

  test "calculate_3d_distance_xy_direction" do
    a = {0, 0, 0}
    b = {3, 4, 0}
    assert GeoMeasure.Distance.calculate(a, b) == 5.0
  end

  test "calculate_3d_distance_xyz_direction" do
    a = {0, 0, 0}
    b = {1, 1, 1}
    assert GeoMeasure.Distance.calculate(a, b) == 1.7320508075688772
  end

  test "calculate_distance_x_direction_point" do
    a = %Geo.Point{coordinates: {0, 0}}
    b = %Geo.Point{coordinates: {5, 0}}
    assert GeoMeasure.Distance.calculate(a, b) == 5.0
  end

  test "calculate_distance_y_direction_point" do
    a = %Geo.Point{coordinates: {0, 0}}
    b = %Geo.Point{coordinates: {0, 5}}
    assert GeoMeasure.Distance.calculate(a, b) == 5.0
  end

  test "calculate_distance_xy_direction_point" do
    a = %Geo.Point{coordinates: {0, 0}}
    b = %Geo.Point{coordinates: {3, 4}}
    assert GeoMeasure.Distance.calculate(a, b) == 5.0
  end

  test "calculate_distance_xy_direction_pointm" do
    a = %Geo.PointM{coordinates: {0, 0, 5}}
    b = %Geo.PointM{coordinates: {3, 4, 5}}
    assert GeoMeasure.Distance.calculate(a, b) == 5.0
  end

  test "calculate_3d_distance_xyz_direction_pointz" do
    a = %Geo.PointZ{coordinates: {0, 0, 0}}
    b = %Geo.PointZ{coordinates: {1, 1, 1}}
    assert GeoMeasure.Distance.calculate(a, b) == 1.7320508075688772
  end

  test "calculate_3d_distance_xyz_direction_pointzm" do
    a = %Geo.PointZM{coordinates: {0, 0, 0, 5}}
    b = %Geo.PointZM{coordinates: {1, 1, 1, 5}}
    assert GeoMeasure.Distance.calculate(a, b) == 1.7320508075688772
  end

  test "calculate_distance_xy_direction_nil_coord" do
    a = {0, nil}
    b = {3, 4}
    assert_raise ArgumentError, fn -> GeoMeasure.Distance.calculate(a, b) end
  end

  test "calculate_distance_xy_direction_point_nil_coord" do
    a = %Geo.Point{coordinates: {0, 0}}
    b = %Geo.Point{coordinates: {nil, 4}}
    assert_raise ArgumentError, fn -> GeoMeasure.Distance.calculate(a, b) end
  end

  test "calculate_distance_xy_direction_pointm_nil_coord" do
    a = %Geo.PointM{coordinates: {0, 0, 5}}
    b = %Geo.PointM{coordinates: {3, nil, 5}}
    assert_raise ArgumentError, fn -> GeoMeasure.Distance.calculate(a, b) end
  end

  test "calculate_distance_xy_direction_pointm_nil_measure" do
    a = %Geo.PointM{coordinates: {0, 0, nil}}
    b = %Geo.PointM{coordinates: {3, 4, 5}}
    assert GeoMeasure.Distance.calculate(a, b) == 5.0
  end

  test "calculate_3d_distance_xyz_direction_pointz_nil_coord" do
    a = %Geo.PointZ{coordinates: {0, nil, 0}}
    b = %Geo.PointZ{coordinates: {1, 1, 1}}
    assert_raise ArgumentError, fn -> GeoMeasure.Distance.calculate(a, b) end
  end

  test "calculate_3d_distance_xyz_direction_pointzm_nil_measure" do
    a = %Geo.PointZM{coordinates: {0, 0, 0, nil}}
    b = %Geo.PointZM{coordinates: {1, 1, 1, nil}}
    assert GeoMeasure.Distance.calculate(a, b) == 1.7320508075688772
  end

  test "calculate_3d_distance_xyz_direction_pointzm_nil_coord" do
    a = %Geo.PointZM{coordinates: {0, 0, nil, 5}}
    b = %Geo.PointZM{coordinates: {1, 1, 1, 5}}
    assert_raise ArgumentError, fn-> GeoMeasure.Distance.calculate(a, b) end
  end
end
