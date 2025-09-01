defmodule GeoMeasure.Utils do
  @moduledoc """
  Contains utility functions to aid the correct handling of data in GeoMeasure.
  """

  @doc """
  Checks if neither of the tuple elements is nil.
  """
  @doc since: "0.0.1"
  @spec tuple_not_nil!(tuple) :: ArgumentError
  def tuple_not_nil!(tpl) when is_tuple(tpl) do
    tpl
    |> Tuple.to_list()
    |> Enum.map(fn x ->
      if is_nil(x) do
        raise ArgumentError, message: "Tuple contains nil value: {#{inspect(tpl)}}"
      end
    end)
  end

  @spec remove_m_values([{number, number, number} | {number, number, number, number}]) :: [
          {number, number} | {number, number, number}
        ]
  def remove_m_values(coords) when is_list(coords) do
    Enum.map(coords, fn
      {a, b, _c} -> {a, b}
      {a, b, c, _d} -> {a, b, c}
      _ -> raise ArgumentError, message: "Wrong tuple size: {#{inspect(coords)}}"
    end)
  end

  @spec remove_z_values([{number, number, number} | {number, number, number, number}]) :: [{number, number} | {number, number, number}]
  def remove_z_values(coords) when is_list(coords) do
    Enum.map(coords, fn
      {a, b, _c} -> {a, b}
      {a, b, _c, d} -> {a, b, d}
      _ -> raise ArgumentError, message: "Wrong tuple size: {#{inspect(coords)}}"
    end)
  end

  @spec linestringz_to_linestring(Geo.LineStringZ.t()) :: Geo.LineString.t()
  def linestringz_to_linestring(%Geo.LineStringZ{coordinates: coords}) do
    %Geo.LineString{coordinates: remove_z_values(coords)}
  end

  @spec linestringzm_to_linestring(Geo.LineStringZM.t()) :: Geo.LineString.t()
  def linestringzm_to_linestring(%Geo.LineStringZM{coordinates: coords}) do
    linestring_coords = remove_m_values(coords) |> remove_z_values()
    %Geo.LineString{coordinates: linestring_coords}
  end

  @spec polygonz_to_polygon(Geo.PolygonZ.t()) :: Geo.Polygon.t()
  def polygonz_to_polygon(%Geo.PolygonZ{coordinates: coords}) do
    polygon_coords = Enum.map(coords, &remove_z_values/1)
    %Geo.Polygon{coordinates: polygon_coords}
  end
end
