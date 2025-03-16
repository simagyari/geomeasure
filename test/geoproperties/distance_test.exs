defmodule GeoProperties.Distance.Test do
  use ExUnit.Case, async: true

  test "calculate_distance_x_direction" do
    a = {0, 0}
    b = {5, 0}
    assert GeoProperties.Distance.distance(a, b) == 5.0
  end

  test "calculate_distance_y_direction" do
    a = {0, 0}
    b = {0, 5}
    assert GeoProperties.Distance.distance(a, b) == 5.0
  end

  test "calculate_distance_xy_direction" do
    a = {0, 0}
    b = {3, 4}
    assert GeoProperties.Distance.distance(a, b) == 5.0
  end
end
