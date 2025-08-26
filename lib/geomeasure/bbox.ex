defmodule GeoMeasure.Bbox do
  @moduledoc false

  alias GeoMeasure.{Extent, Utils}

  @spec calculate_bbox([{number, number}], integer | nil) :: Geo.Polygon.t()
  defp calculate_bbox(coords, srid) do
    {min_x, max_x, min_y, max_y} = Extent.calculate_extent(coords)

    %Geo.Polygon{
      coordinates: [
        [
          {min_x, min_y},
          {min_x, max_y},
          {max_x, max_y},
          {max_x, min_y},
          {min_x, min_y}
        ]
      ],
      srid: srid
    }
  end

  @spec calculate_bbox_3d([{number, number, number}], integer | nil) :: Geo.Polygon.t()
  defp calculate_bbox_3d(coords, srid) do
    {min_x, max_x, min_y, max_y, min_z, max_z} = Extent.calculate_extent_3d(coords)

    %Geo.Polygon{
      coordinates: [
        [
          {min_x, min_y},
          {min_x, max_y},
          {max_x, max_y},
          {max_x, min_y},
          {min_x, min_y}
        ]
      ],
      srid: srid,
      properties: %{min_z: min_z, max_z: max_z}
    }
  end

  @doc """
  Calculates the bounding box of a Geo struct.
  """
  @doc since: "0.0.1"
  @spec calculate(Geo.Point.t()) :: Geo.Point.t()
  def calculate(%Geo.Point{coordinates: coords} = point) do
    Utils.tuple_not_nil!(coords)
    point
  end

  @spec calculate(Geo.PointM.t()) :: Geo.Point.t()
  def calculate(%Geo.PointM{coordinates: {x, y, _}, srid: srid}) do
    Utils.tuple_not_nil!({x, y})
    %Geo.Point{coordinates: {x, y}, srid: srid}
  end

  @spec calculate(Geo.PointZ.t()) :: Geo.PointZ.t()
  def calculate(%Geo.PointZ{coordinates: coords, srid: srid}) do
    Utils.tuple_not_nil!(coords)
    %Geo.PointZ{coordinates: coords, srid: srid}
  end

  @spec calculate(Geo.PointZM.t()) :: Geo.PointZ.t()
  def calculate(%Geo.PointZM{coordinates: {x, y, z, _}, srid: srid}) do
    Utils.tuple_not_nil!({x, y, z})
    %Geo.PointZ{coordinates: {x, y, z}, srid: srid}
  end

  @spec calculate(Geo.LineString.t()) :: Geo.Polygon.t()
  def calculate(%Geo.LineString{coordinates: coords, srid: srid}) do
    calculate_bbox(coords, srid)
  end

  @spec calculate(Geo.LineStringZ.t()) :: Geo.Polygon.t()
  def calculate(%Geo.LineStringZ{coordinates: coords, srid: srid}) do
    calculate_bbox_3d(coords, srid)
  end

  @spec calculate(Geo.LineStringZM.t()) :: Geo.Polygon.t()
  def calculate(%Geo.LineStringZM{coordinates: coords, srid: srid}) do
    coords
    |> Utils.remove_m_values()
    |> calculate_bbox_3d(srid)
  end

  @spec calculate(Geo.Polygon.t()) :: Geo.Polygon.t()
  def calculate(%Geo.Polygon{coordinates: coords, srid: srid}) do
    coords
    |> hd()
    |> tl()
    |> calculate_bbox(srid)
  end

  @spec calculate(Geo.PolygonZ.t()) :: Geo.Polygon.t()
  def calculate(%Geo.PolygonZ{coordinates: coords, srid: srid}) do
    coords
    |> hd()
    |> tl()
    |> calculate_bbox_3d(srid)
  end
end
