defmodule GeoProperties do
  @moduledoc """
  Calculates properties of Geo structs.
  """

  alias Geo
  alias GeoProperties.{
    Area,
    Bbox,
    Centroid,
    Extent,
    Perimeter
  }

  @spec area(Geo.geometry()) :: number() | nil
  defdelegate area(geometry), to: Area

  @spec bbox(Geo.geometry()) :: Geo.geometry()
  defdelegate bbox(geometry), to: Bbox

  @spec centroid(Geo.geometry()) :: Geo.Point.t()
  defdelegate centroid(geometry), to: Centroid

  @spec extent(Geo.geometry()) :: {number(), number(), number(), number()} | nil
  defdelegate extent(geometry), to: Extent

  @spec perimeter(Geo.geometry()) :: float() | nil
  defdelegate perimeter(geometry), to: Perimeter

end
