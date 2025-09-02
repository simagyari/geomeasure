defmodule GeoMeasure.Area do
  @moduledoc false

  alias GeoMeasure.Utils

  @spec calculate_area([{number, number}]) :: float
  defp calculate_area(coords) do
    Enum.each(coords, &Utils.tuple_not_nil!/1)

    coords
    |> Enum.reduce({0, tl(coords)}, fn item, accumulator ->
      {x1, y1} = item

      case accumulator do
        {acc, [{x2, y2} | rest]} ->
          acc = acc + x1 * y2 - x2 * y1
          {acc, rest}

        {acc, []} ->
          acc
      end
    end)
    |> abs()
    |> Kernel./(2)
  end

  @spec calculate_area_3d([{number, number, number}]) :: float
  defp calculate_area_3d(coords) do
    Enum.each(coords, &Utils.tuple_not_nil!/1)
    [_, point_0 | rest] = coords

    rest
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(0, fn [point_1, point_2], acc ->
      acc + triangle_area(point_0, point_1, point_2)
    end)
    |> Kernel./(2)
  end

  @spec triangle_area(
          {number, number, number},
          {number, number, number},
          {number, number, number}
        ) :: {number, number, number}
  defp triangle_area({x0, y0, z0}, {x1, y1, z1}, {x2, y2, z2}) do
    u = {x1 - x0, y1 - y0, z1 - z0}
    v = {x2 - x0, y2 - y0, z2 - z0}
    cross = cross_product(u, v)

    cross
    |> Enum.reduce(0, fn element, acc -> acc + element * element end)
    |> :math.sqrt()
  end

  @spec cross_product({number, number, number}, {number, number, number}) ::
          {number, number, number}
  defp cross_product({ux, uy, uz}, {vx, vy, vz}) do
    [
      uy * vz - uz * vy,
      uz * vx - ux * vz,
      ux * vy - uy * vx
    ]
  end

  @doc """
  Calculates the area of a Geo struct.
  """
  @doc since: "0.0.1"

  @spec calculate(Geo.Polygon.t()) :: float
  def calculate(%Geo.Polygon{coordinates: [outer_ring, inner_ring | rest]}) do
    outer_area = calculate_area(outer_ring)

    inner_area =
      Enum.reduce([inner_ring] ++ rest, 0, fn coord_list, acc ->
        acc + calculate_area(coord_list)
      end)

    outer_area - inner_area
  end

  @spec calculate(Geo.Polygon.t()) :: float
  def calculate(%Geo.Polygon{coordinates: [outer_ring]}) do
    calculate_area(outer_ring)
  end

  @spec calculate(Geo.PolygonZ.t()) :: float
  def calculate(%Geo.PolygonZ{coordinates: [outer_ring, inner_ring | rest]}) do
    outer_area = calculate_area_3d(outer_ring)

    inner_area =
      Enum.reduce([inner_ring] ++ rest, 0, fn coord_list, acc ->
        acc + calculate_area_3d(coord_list)
      end)

    outer_area - inner_area
  end

  @spec calculate(Geo.PolygonZ.t()) :: float
  def calculate(%Geo.PolygonZ{coordinates: [outer_ring]}) do
    calculate_area_3d(outer_ring)
  end
end
