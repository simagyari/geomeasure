# Changelog

## v1.0.0 - 2025-03-29

### Potentially breaking change: [Removed implementations that returned `nil` until now](https://github.com/simagyari/geomeasure/pull/5)

This aligns with BEAM's "let it break" principle, raising a `FunctionClauseError` at the earliest possible occasion, making error handling as transparent as possible.

### Potentially breaking change: [Renamed submodule functions to `calculate` instead of lowercase submodule name](https://github.com/simagyari/geomeasure/pull/9)

This enhances the uniformity and readability of the code, making sure that it is obvious, what does what.

### Potentially breaking change: [Input geometries with `nil` in coordinates raise `ArgumentError`](https://github.com/simagyari/geomeasure/pull/12)

This ensures that the package raises a uniform ArgumentError upon encountering `nil` coordinates, making its behaviour more predictable.

### Other changes:

- [Reduced the number of iterations over the coordinate list in the centroid calculation for better performance](https://github.com/simagyari/geomeasure/pull/11)
- [Pulled together all documentation in the `GeoMeasure` module](https://github.com/simagyari/geomeasure/pull/6)
- [Added support table to the README, removed submodule call examples](https://github.com/simagyari/geomeasure/pull/7)

## v0.0.1 - 2025-03-21

- First publication of the package

- Enhancements

    - Created functions for the calculation of the supported properties (area, bounding box, centroid, distance, extent, perimeter) for the supported structs (Point, LineString, Polygon)
    - Added convenience shortcuts from the main GeoMeasure module in the form of delegates to the specific modules containing the actual functions.