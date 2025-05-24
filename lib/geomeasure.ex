defmodule GeoMeasure do
  @moduledoc """
  Calculates properties of Geo structs.

  ## area

  Calculates the area of Geo struct.

  #### Examples:

      iex> GeoMeasure.area(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
      4.0

  ## bbox

  Calculates the bounding box of a Geo struct.

  #### Examples:

      iex> GeoMeasure.bbox(%Geo.Point{coordinates: {1, 2}})
      %Geo.Point{coordinates: {1, 2}}

      iex> GeoMeasure.bbox(%Geo.PointM{coordinates: {1, 2, 5}})
      %Geo.Point{coordinates: {1, 2}}

      iex> GeoMeasure.bbox(%Geo.PointZ{coordinates: {1, 2, 5}})
      %Geo.PointZ{coordinates: {1, 2, 5}}

      iex> GeoMeasure.bbox(%Geo.PointZM{coordinates: {1, 2, 5, 8}})
      %Geo.PointZ{coordinates: {1, 2, 5}}

      iex> GeoMeasure.bbox(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
      %Geo.Polygon{coordinates: [[{1, 2}, {1, 4}, {3, 4}, {3, 2}, {1, 2}]]}

      iex> GeoMeasure.bbox(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
      %Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]}

  ## centroid

  Calculates the centroid of a Geo struct.

  #### Examples:

      iex> GeoMeasure.centroid(%Geo.Point{coordinates: {1, 2}})
      %Geo.Point{coordinates: {1, 2}}

      iex> GeoMeasure.centroid(%Geo.PointM{coordinates: {1, 2, 5}})
      %Geo.Point{coordinates: {1, 2}}

      iex> GeoMeasure.centroid(%Geo.PointZ{coordinates: {1, 2, 5}})
      %Geo.PointZ{coordinates: {1, 2, 5}}

      iex> GeoMeasure.centroid(%Geo.PointZM{coordinates: 1, 2, 5, 8})
      %Geo.PointZ{coordinates: {1, 2, 5}}

      iex> GeoMeasure.centroid(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
      %Geo.Point{coordinates: {2.0, 3.0}}

      iex> GeoMeasure.centroid(%Geo.LineStringZ{coordinates: [{1, 2, 3}, {3, 4, 5}]})
      %Geo.PointZ{coordinates: {2.0, 3.0, 4.0}}

      iex> GeoMeasure.centroid(%Geo.LineStringZM{coordinates: [{1, 2, 3, 10}, {3, 4, 5, 11}]})
      %Geo.PointZ{coordinates: {2.0, 3.0, 4.0}}

      iex> GeoMeasure.centroid(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
      %Geo.Point{coordinates: {1.0, 1.0}}

  ## distance

  Calculates distance between two coordinate pairs or Geo.Point structs.

  #### Examples:

      iex> GeoMeasure.distance({0, 0}, {5, 0})
      5.0

      iex> GeoMeasure.distance({0, 0}, {3, 4})
      5.0

      iex> GeoMeasure.distance({0, 0, 0}, {1, 1, 1})
      1.7320508075688772

      iex> GeoMeasure.distance(%Geo.Point{coordinates: {0, 0}}, %Geo.Point{coordinates: {3, 4}})
      5.0

      iex> GeoMeasure.distance(%Geo.PointM{coordinates: {0, 0, 5}}, %Geo.PointM{coordinates: {3, 4, 10}})
      5.0

      iex> GeoMeasure.distance(%Geo.PointM{coordinates: {0, 0, 5}}, %Geo.Point{coordinates: {3, 4}})
      5.0

      iex> GeoMeasure.distance(%Geo.PointZ{coordinates: {0, 0, 0}}, Geo.PointZ{coordinates: {1, 1, 1}})
      1.7320508075688772

      iex> GeoMeasure.distance(%Geo.PointZM{coordinates: {0, 0, 0, 8}}, Geo.PointZM{coordinates: {1, 1, 1, 6}})
      1.7320508075688772

      iex> GeoMeasure.distance(%Geo.PointZM{coordinates: {0, 0, 0, 8}}, %Geo.PointZ{coordinates: {1, 1, 1}})
      1.7320508075688772

  ## extent

  Calculates the extent of a Geo struct.

  #### Examples:

      iex> GeoMeasure.extent(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
      {1, 3, 2, 4}

      iex> GeoMeasure.extent(%Geo.LineStringZ{coordinates: [{1, 2, 3}, {3, 4, 5}]})
      {1, 3, 2, 4, 3, 5}

      iex> GeoMeasure.extent(%Geo.LineStringZM{coordinates: [{1, 2, 3, 10}, {3, 4, 5, 11}]})
      {1, 3, 2, 4, 3, 5}

      iex> GeoMeasure.extent(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
      {0, 2, 0, 2}

  ## perimeter/length

  Calculates the perimeter or length of a Geo struct.

  #### Examples:

      iex> GeoMeasure.length(%Geo.LineString{coordinates: [{1, 2}, {1, 4}]})
      2.0

      iex> GeoMeasure.length(%Geo.LineStringZ{coordinates: [{1, 2, 2}, {1, 4, 2}]})
      2.0

      iex> GeoMeasure.length(%Geo.LineStringZM{coordinates: [{1, 2, 2, 10}, {1, 4, 2, 11}]})
      2.0

      iex> GeoMeasure.perimeter(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
      8.0

  """

  alias Geo

  alias GeoMeasure.{
    Area,
    Bbox,
    Centroid,
    Distance,
    Extent,
    Perimeter
  }

  @type geo_point :: Geo.Point.t() | Geo.PointM.t() | Geo.PointZ.t() | Geo.PointZM.t()
  @type geo_line :: Geo.LineString.t() | Geo.LineStringZ.t() | Geo.LineStringZM.t()

  @doc """
  Calculates the area of a Geo struct.
  """
  @doc since: "0.0.1"
  @spec area(Geo.geometry()) :: float
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
  @spec extent(Geo.geometry()) :: {number, number, number, number}
  defdelegate extent(geometry), to: Extent, as: :calculate

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
  @spec perimeter(Geo.Polygon.t()) :: float
  defdelegate perimeter(geometry), to: Perimeter, as: :calculate
end
