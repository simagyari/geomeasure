# GeoCalc

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
    {:geocalc, "~> 1.0"}
  ]
end
```
## Examples

Each function can be called through their module, such as `GeoCalc.Area.area` or `GeoCalc.Perimeter.perimeter`. Alternatively, as a convenience, delegates have been implemented from the main `GeoCalc` module, enabling shortened calls, such as `GeoCalc.area` or `GeoCalc.perimeter`.

### Area

Calling through the `GeoCalc.Area` module:

```elixir
iex(1)> GeoCalc.Area.area(%Geo.Point{coordinates: {1, 2}})
nil

iex(2)> GeoCalc.Area.area(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
nil

iex(3)> GeoCalc.Area.area(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
4.0
```

Calling through the `GeoCalc` module:

```elixir
iex(1)> GeoCalc.area(%Geo.Point{coordinates: {1, 2}})
nil

iex(2)> GeoCalc.area(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
nil

iex(3)> GeoCalc.area(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
4.0
```

### Bounding Box

Calling through the `GeoCalc.Bbox` module:

```elixir
iex(1)> GeoCalc.Bbox.bbox(%Geo.Point{coordinates: {1, 2}})
%Geo.Point{coordinates: {1, 2}, srid: nil, properties: %{}}

iex(2)> GeoCalc.Bbox.bbox(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
%Geo.Polygon{
  coordinates: [[{1, 2}, {1, 4}, {3, 4}, {3, 2}, {1, 2}]],
  srid: nil,
  properties: %{}
}

iex(3)> GeoCalc.Bbox.bbox(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
%Geo.Polygon{
  coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]],
  srid: nil,
  properties: %{}
}
```

Calling through the `GeoCalc` module:

```elixir
iex(1)> GeoCalc.bbox(%Geo.Point{coordinates: {1, 2}})
%Geo.Point{coordinates: {1, 2}, srid: nil, properties: %{}}

iex(2)> GeoCalc.bbox(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
%Geo.Polygon{
  coordinates: [[{1, 2}, {1, 4}, {3, 4}, {3, 2}, {1, 2}]],
  srid: nil,
  properties: %{}
}

iex(3)> GeoCalc.bbox(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
%Geo.Polygon{
  coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]],
  srid: nil,
  properties: %{}
}
```

### Centroid

Calling through the `GeoCalc.Centroid` module:

```elixir
iex(1)> GeoCalc.Centroid.centroid(%Geo.Point{coordinates: {1, 2}})
%Geo.Point{coordinates: {1, 2}, srid: nil, properties: %{}}

iex(2)> GeoCalc.Centroid.centroid(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
%Geo.Point{coordinates: {2.0, 3.0}, srid: nil, properties: %{}}

iex(3)> GeoCalc.Centroid.centroid(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
%Geo.Point{coordinates: {1.0, 1.0}, srid: nil, properties: %{}}
```

Calling through the `GeoCalc` module:

```elixir
iex(1)> GeoCalc.centroid(%Geo.Point{coordinates: {1, 2}})
%Geo.Point{coordinates: {1, 2}, srid: nil, properties: %{}}

iex(2)> GeoCalc.centroid(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
%Geo.Point{coordinates: {2.0, 3.0}, srid: nil, properties: %{}}

iex(3)> GeoCalc.centroid(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
%Geo.Point{coordinates: {1.0, 1.0}, srid: nil, properties: %{}}
```

### Extent

Calling through the `GeoCalc.Extent` module:

```elixir
iex(1)> GeoCalc.Extent.extent(%Geo.Point{coordinates: {1, 2}})
nil

iex(2)> GeoCalc.Extent.extent(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
{1, 3, 2, 4}

iex(3)> GeoCalc.Extent.extent(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
{0, 2, 0, 2}
```

Calling through the `GeoCalc` module:

```elixir
iex(1)> GeoCalc.extent(%Geo.Point{coordinates: {1, 2}})
nil

iex(2)> GeoCalc.extent(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
{1, 3, 2, 4}

iex(3)> GeoCalc.extent(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
{0, 2, 0, 2}
```

### Perimeter

Calling through the `GeoCalc.Perimeter` module:

```elixir
iex(1)> GeoCalc.Perimeter.perimeter(%Geo.Point{coordinates: {1, 2}})
nil

iex(2)> GeoCalc.Perimeter.perimeter(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
nil

iex(3)> GeoCalc.Perimeter.perimeter(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
8.0
```

Calling through the `GeoCalc` module:

```elixir
iex(1)> GeoCalc.perimeter(%Geo.Point{coordinates: {1, 2}})
nil

iex(2)> GeoCalc.perimeter(%Geo.LineString{coordinates: [{1, 2}, {3, 4}]})
nil

iex(3)> GeoCalc.perimeter(%Geo.Polygon{coordinates: [[{0, 0}, {0, 2}, {2, 2}, {2, 0}, {0, 0}]]})
8.0
```

## Copyright and License

Copyright (c) 2024 simagyari

Released under the MIT License, which can be found in the repository's [LICENSE](https://github.com/simagyari/geocalc/blob/main/LICENSE) file.