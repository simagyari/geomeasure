defmodule GeoMeasure do
  @moduledoc """
  Calculates properties of Geo structs.
  """

  alias Geo

  alias GeoMeasure.{
    Area,
    Bbox,
    Centroid,
    Distance,
    Extent,
    FootprintArea,
    FootprintPerimeter,
    Perimeter
  }

  @type geo_point :: Geo.Point.t() | Geo.PointM.t() | Geo.PointZ.t() | Geo.PointZM.t()
  @type geo_line :: Geo.LineString.t() | Geo.LineStringZ.t() | Geo.LineStringZM.t()
  @type geo_polygon :: Geo.Polygon.t() | Geo.PolygonZ.t()

  @doc """
  Calculates the area of a Geo struct.
  """
  @doc since: "0.0.1"
  @spec area(geo_polygon()) :: float
  defdelegate area(geometry), to: Area, as: :calculate

  @doc """
  Calculates the bounding box of a Geo struct.
  """
  @doc since: "0.0.1"
  @spec bbox(Geo.geometry()) :: Geo.Point.t() | Geo.PointZ.t() | Geo.Polygon.t()
  defdelegate bbox(geometry), to: Bbox, as: :calculate

  @doc """
  Calculates the centroid of a Geo struct.
  """
  @doc since: "0.0.1"
  @spec centroid(Geo.geometry()) :: Geo.Point.t() | Geo.PointZ.t()
  defdelegate centroid(geometry), to: Centroid, as: :calculate

  @doc """
  Calculates the distance between two coordinate pairs or points.
  """
  @doc since: "0.0.1"
  @spec distance({number(), number()}, {number(), number()}) :: float
  @spec distance(geo_point(), geo_point()) :: float()
  defdelegate distance(coordinates_1, coordinates_2), to: Distance, as: :calculate

  @doc """
  Calculates the extent coordinates of a Geo struct.
  """
  @doc since: "0.0.1"
  @spec extent(geo_line() | geo_polygon()) :: {number, number, number, number}
  defdelegate extent(geometry), to: Extent, as: :calculate

  @doc """
  Calculates the area of the footprint of a 3D Geo struct.
  """
  @doc since: "1.7.0"
  @spec footprint_area(Geo.PolygonZ.t()) :: float
  defdelegate footprint_area(geometry), to: FootprintArea, as: :calculate

  @doc """
  Calculates the length of a 3D linear Geo struct.
  """
  @doc since: "1.7.0"
  @spec footprint_length(Geo.LineStringZ.t() | Geo.LineStringZM.t()) :: float
  defdelegate footprint_length(geometry), to: FootprintPerimeter, as: :calculate

  @doc """
  Calculates the perimeter of a 3D polygonal Geo struct.
  """
  @doc since: "1.7.0"
  @spec footprint_perimeter(Geo.PolygonZ.t()) :: float
  defdelegate footprint_perimeter(geometry), to: FootprintPerimeter, as: :calculate

  @doc """
  Calculates the length of a linear Geo struct.
  """
  @doc since: "1.3.0"
  @spec length(geo_line()) :: float
  defdelegate length(geometry), to: Perimeter, as: :calculate

  @doc """
  Calculates the perimeter of a polygonal Geo struct.
  """
  @doc since: "0.0.1"
  @spec perimeter(geo_polygon()) :: float
  defdelegate perimeter(geometry), to: Perimeter, as: :calculate
end
