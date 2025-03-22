# GeoMeasure

[![Build Status](https://github.com/simagyari/geomeasure/actions/workflows/elixir-build-and-test.yml/badge.svg?branch=main)](https://github.com/simagyari/geomeasure/actions/workflows/elixir-build-and-test.yml)
[![Module Version](https://img.shields.io/hexpm/v/geomeasure.svg)](https://hex.pm/packages/geomeasure)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/geomeasure/)
[![Total Download](https://img.shields.io/hexpm/dt/geomeasure.svg)](https://hex.pm/packages/geomeasure)
[![License](https://img.shields.io/hexpm/l/geomeasure.svg)](https://github.com/simagyari/geomeasure/blob/main/LICENSE)
[![Last Updated](https://img.shields.io/github/last-commit/simagyari/geomeasure.svg)](https://github.com/simagyari/geomeasure/commits/main)

A collection of functions calculating different properties of [Geo](https://github.com/felt/geo/tree/master) structs.

Currently, this project supports only the following geometries:

- Point
- LineString
- Polygon

Currently, the following properties can be calculated for the supported [Geo](https://github.com/felt/geo/tree/master) structs:

- Area
- Bounding box
- Centroid
- Distance (between two coordinate pairs or Geo.Point structs)
- Extent
- Perimeter

_Note_: If you would like to make in-memory calculations to determine the relationship between two Geo structs, please check out [topo](https://github.com/pkinney/topo).

```elixir
defp deps do
  [
    {:geomeasure, "~> 0.0.1"}
  ]
end
```
## Examples

Each function can be called through their module, such as `GeoMeasure.Area.area` or `GeoMeasure.Perimeter.perimeter`. Alternatively, as a convenience, delegates have been implemented from the main `GeoMeasure` module, enabling shortened calls, such as `GeoMeasure.area` or `GeoMeasure.perimeter`.

### Area

Calling through the `GeoMeasure.Area` module:

```elixir
iex(1)> GeoMeasure.Area.area(%Geo.Point{coordinates: {1, 2}})
nil

iex(2)> GeoMeasure.Area.area(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
nil

iex(3)> GeoMeasure.Area.area(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
4.0
```

Calling through the `GeoMeasure` module:

```elixir
iex(1)> GeoMeasure.area(%Geo.Point{coordinates: {1, 2}})
nil

iex(2)> GeoMeasure.area(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
nil

iex(3)> GeoMeasure.area(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
4.0
```

### Bounding Box

Calling through the `GeoMeasure.Bbox` module:

```elixir
iex(1)> GeoMeasure.Bbox.bbox(%Geo.Point{coordinates: {1, 2}})
%Geo.Point{coordinates: {1, 2}, srid: nil, properties: %{}}

iex(2)> GeoMeasure.Bbox.bbox(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
%Geo.Polygon{
  coordinates: [[{1, 2}, {1, 4}, {3, 4}, {3, 2}, {1, 2}]],
  srid: nil,
  properties: %{}
}

iex(3)> GeoMeasure.Bbox.bbox(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
%Geo.Polygon{
  coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]],
  srid: nil,
  properties: %{}
}
```

Calling through the `GeoMeasure` module:

```elixir
iex(1)> GeoMeasure.bbox(%Geo.Point{coordinates: {1, 2}})
%Geo.Point{coordinates: {1, 2}, srid: nil, properties: %{}}

iex(2)> GeoMeasure.bbox(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
%Geo.Polygon{
  coordinates: [[{1, 2}, {1, 4}, {3, 4}, {3, 2}, {1, 2}]],
  srid: nil,
  properties: %{}
}

iex(3)> GeoMeasure.bbox(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
%Geo.Polygon{
  coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]],
  srid: nil,
  properties: %{}
}
```

### Centroid

Calling through the `GeoMeasure.Centroid` module:

```elixir
iex(1)> GeoMeasure.Centroid.centroid(%Geo.Point{coordinates: {1, 2}})
%Geo.Point{coordinates: {1, 2}, srid: nil, properties: %{}}

iex(2)> GeoMeasure.Centroid.centroid(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
%Geo.Point{coordinates: {2.0, 3.0}, srid: nil, properties: %{}}

iex(3)> GeoMeasure.Centroid.centroid(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
%Geo.Point{coordinates: {1.0, 1.0}, srid: nil, properties: %{}}
```

Calling through the `GeoMeasure` module:

```elixir
iex(1)> GeoMeasure.centroid(%Geo.Point{coordinates: {1, 2}})
%Geo.Point{coordinates: {1, 2}, srid: nil, properties: %{}}

iex(2)> GeoMeasure.centroid(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
%Geo.Point{coordinates: {2.0, 3.0}, srid: nil, properties: %{}}

iex(3)> GeoMeasure.centroid(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
%Geo.Point{coordinates: {1.0, 1.0}, srid: nil, properties: %{}}
```

### Distance

Calling through the `GeoMeasure.Distance` module:

```elixir
iex(1)> GeoMeasure.Distance.distance({0, 0}, {5, 0})
5.0

iex(2)> GeoMeasure.Distance.distance({0, 0}, {3, 4})
5.0

iex(3)> GeoMeasure.Distance.distance(%Geo.Point{coordinates: {0, 0}}, %Geo.Point{coordinates: {3, 4}})
5.0
```

Calling through the `GeoMeasure` module:

```elixir
iex(1)> GeoMeasure.distance({0, 0}, {5, 0})
5.0

iex(2)> GeoMeasure.distance({0, 0}, {3, 4})
5.0

iex(3)> GeoMeasure.distance(%Geo.Point{coordinates: {0, 0}}, %Geo.Point{coordinates: {3, 4}})
5.0
```

### Extent

Calling through the `GeoMeasure.Extent` module:

```elixir
iex(1)> GeoMeasure.Extent.extent(%Geo.Point{coordinates: {1, 2}})
nil

iex(2)> GeoMeasure.Extent.extent(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
{1, 3, 2, 4}

iex(3)> GeoMeasure.Extent.extent(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
{0, 2, 0, 2}
```

Calling through the `GeoMeasure` module:

```elixir
iex(1)> GeoMeasure.extent(%Geo.Point{coordinates: {1, 2}})
nil

iex(2)> GeoMeasure.extent(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
{1, 3, 2, 4}

iex(3)> GeoMeasure.extent(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
{0, 2, 0, 2}
```

### Perimeter

Calling through the `GeoMeasure.Perimeter` module:

```elixir
iex(1)> GeoMeasure.Perimeter.perimeter(%Geo.Point{coordinates: {1, 2}})
nil

iex(2)> GeoMeasure.Perimeter.perimeter(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
nil

iex(3)> GeoMeasure.Perimeter.perimeter(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
8.0
```

Calling through the `GeoMeasure` module:

```elixir
iex(1)> GeoMeasure.perimeter(%Geo.Point{coordinates: {1, 2}})
nil

iex(2)> GeoMeasure.perimeter(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
nil

iex(3)> GeoMeasure.perimeter(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
8.0
```

## Copyright and License

Copyright (c) 2024 simagyari

Released under the MIT License, which can be found in the repository's [LICENSE](https://github.com/simagyari/geomeasure/blob/main/LICENSE) file.