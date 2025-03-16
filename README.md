# GeoProperties

A collection of functions calculating different properties of [Geo](https://github.com/felt/geo/tree/master) structs.

Currently, this project supports only the following geometries:

- Point
- LineString
- Polygon

Currently, the following properties can be calculated for the supported [Geo](https://github.com/felt/geo/tree/master) structs:

- Area
- Bounding box
- Centroid
- Extent
- Perimeter

_Note_: If you would like to make in-memory calculations to determine the relationship between two Geo structs, please check out [topo](https://github.com/pkinney/topo).

```elixir
defp deps do
  [
    {:geoproperties, "~> 1.0"}
  ]
end
```
## Examples

Each function can be called through their module, such as `GeoProperties.Area.area` or `GeoProperties.Perimeter.perimeter`. Alternatively, as a convenience, delegates have been implemented from the main `GeoProperties` module, enabling shortened calls, such as `GeoProperties.area` or `GeoProperties.perimeter`.

### Area

Calling through the `GeoProperties.Area` module:

```elixir
iex(1)> GeoProperties.Area.area(%Geo.Point{coordinates: {1, 2}})
nil

iex(2)> GeoProperties.Area.area(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
nil

iex(3)> GeoProperties.Area.area(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
4.0
```

Calling through the `GeoProperties` module:

```elixir
iex(1)> GeoProperties.area(%Geo.Point{coordinates: {1, 2}})
nil

iex(2)> GeoProperties.area(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
nil

iex(3)> GeoProperties.area(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
4.0
```

### Bounding Box

Calling through the `GeoProperties.Bbox` module:

```elixir
iex(1)> GeoProperties.Bbox.bbox(%Geo.Point{coordinates: {1, 2}})
%Geo.Point{coordinates: {1, 2}, srid: nil, properties: %{}}

iex(2)> GeoProperties.Bbox.bbox(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
%Geo.Polygon{
  coordinates: [[{1, 2}, {1, 4}, {3, 4}, {3, 2}, {1, 2}]],
  srid: nil,
  properties: %{}
}

iex(3)> GeoProperties.Bbox.bbox(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
%Geo.Polygon{
  coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]],
  srid: nil,
  properties: %{}
}
```

Calling through the `GeoProperties` module:

```elixir
iex(1)> GeoProperties.bbox(%Geo.Point{coordinates: {1, 2}})
%Geo.Point{coordinates: {1, 2}, srid: nil, properties: %{}}

iex(2)> GeoProperties.bbox(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
%Geo.Polygon{
  coordinates: [[{1, 2}, {1, 4}, {3, 4}, {3, 2}, {1, 2}]],
  srid: nil,
  properties: %{}
}

iex(3)> GeoProperties.bbox(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
%Geo.Polygon{
  coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]],
  srid: nil,
  properties: %{}
}
```

### Centroid

Calling through the `GeoProperties.Centroid` module:

```elixir
iex(1)> GeoProperties.Centroid.centroid(%Geo.Point{coordinates: {1, 2}})
%Geo.Point{coordinates: {1, 2}, srid: nil, properties: %{}}

iex(2)> GeoProperties.Centroid.centroid(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
%Geo.Point{coordinates: {2.0, 3.0}, srid: nil, properties: %{}}

iex(3)> GeoProperties.Centroid.centroid(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
%Geo.Point{coordinates: {1.0, 1.0}, srid: nil, properties: %{}}
```

Calling through the `GeoProperties` module:

```elixir
iex(1)> GeoProperties.centroid(%Geo.Point{coordinates: {1, 2}})
%Geo.Point{coordinates: {1, 2}, srid: nil, properties: %{}}

iex(2)> GeoProperties.centroid(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
%Geo.Point{coordinates: {2.0, 3.0}, srid: nil, properties: %{}}

iex(3)> GeoProperties.centroid(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
%Geo.Point{coordinates: {1.0, 1.0}, srid: nil, properties: %{}}
```

### Extent

Calling through the `GeoProperties.Extent` module:

```elixir
iex(1)> GeoProperties.Extent.extent(%Geo.Point{coordinates: {1, 2}})
nil

iex(2)> GeoProperties.Extent.extent(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
{1, 3, 2, 4}

iex(3)> GeoProperties.Extent.extent(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
{0, 2, 0, 2}
```

Calling through the `GeoProperties` module:

```elixir
iex(1)> GeoProperties.extent(%Geo.Point{coordinates: {1, 2}})
nil

iex(2)> GeoProperties.extent(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
{1, 3, 2, 4}

iex(3)> GeoProperties.extent(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
{0, 2, 0, 2}
```

### Perimeter

Calling through the `GeoProperties.Perimeter` module:

```elixir
iex(1)> GeoProperties.Perimeter.perimeter(%Geo.Point{coordinates: {1, 2}})
nil

iex(2)> GeoProperties.Perimeter.perimeter(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
nil

iex(3)> GeoProperties.Perimeter.perimeter(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
8.0
```

Calling through the `GeoProperties` module:

```elixir
iex(1)> GeoProperties.perimeter(%Geo.Point{coordinates: {1, 2}})
nil

iex(2)> GeoProperties.perimeter(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
nil

iex(3)> GeoProperties.perimeter(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
8.0
```

## Copyright and License

Copyright (c) 2025 Sándor István Magyari

Released under the MIT License, which can be found in the repository's [LICENSE](https://github.com/simagyari/geoproperties/blob/main/LICENSE) file.