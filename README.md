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

For each geometry, only the properties that have meaning for the given geometry are implemented. This results in the following implementation table, where :white_check_mark: means supported, and :x: means unsupported property:

| Geometry   | Area | Bounding box | Centroid | Distance | Extent | Perimeter |
| ---------- | :--: | :----------: | :------: | :------: | :----: | :-------: |
| Point      | ❌   | ✅          | ✅       | ✅      | ❌     | ❌       |
| LineString | ❌   | ✅          | ✅       | ❌      | ✅     | ❌       |
| Polygon    | ✅   | ✅          | ✅       | ❌      | ✅     | ✅       |

_Note_: If you would like to make in-memory calculations to determine the relationship between two Geo structs, please check out [topo](https://github.com/pkinney/topo).

```elixir
defp deps do
  [
    {:geomeasure, "~> 0.0.1"}
  ]
end
```
## Examples

While each function can be called through their module, such as `GeoMeasure.Area.calculate` or `GeoMeasure.Perimeter.calculate`, it is encouraged to use delegates from the main `GeoMeasure` module, enabling shortened calls, such as `GeoMeasure.area` or `GeoMeasure.perimeter`. Thus, the following examples will only show the shorter, more convenient calls through `GeoMeasure`.

### Area

```elixir
iex(1)> GeoMeasure.area(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
4.0
```

### Bounding Box

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

```elixir
iex(1)> GeoMeasure.centroid(%Geo.Point{coordinates: {1, 2}})
%Geo.Point{coordinates: {1, 2}, srid: nil, properties: %{}}

iex(2)> GeoMeasure.centroid(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
%Geo.Point{coordinates: {2.0, 3.0}, srid: nil, properties: %{}}

iex(3)> GeoMeasure.centroid(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
%Geo.Point{coordinates: {1.0, 1.0}, srid: nil, properties: %{}}
```

### Distance

```elixir
iex(1)> GeoMeasure.distance({0, 0}, {5, 0})
5.0

iex(2)> GeoMeasure.distance({0, 0}, {3, 4})
5.0

iex(3)> GeoMeasure.distance(%Geo.Point{coordinates: {0, 0}}, %Geo.Point{coordinates: {3, 4}})
5.0
```

### Extent

```elixir
iex(1)> GeoMeasure.extent(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
{1, 3, 2, 4}

iex(2)> GeoMeasure.extent(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
{0, 2, 0, 2}
```

### Perimeter

```elixir
iex(1)> GeoMeasure.perimeter(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
8.0
```

## Copyright and License

Copyright (c) 2024 simagyari

Released under the MIT License, which can be found in the repository's [LICENSE](https://github.com/simagyari/geomeasure/blob/main/LICENSE) file.