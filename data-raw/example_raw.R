# large polygon ----------------------------------------------------------------
large_polygon_geometry <- list(rbind(c(2.5, 0), c(2.5, 10), c(20, 10), c(20, 0), c(2.5, 0))) |>
  sf::st_polygon() |>
  sf::st_sfc(crs = "EPSG:27700")

# attribute field
attribute_field <- tibble::tibble(
  id = 1L
)

## polygon sf object
large_polygon <- sf::st_sf(attribute_field, geometry = large_polygon_geometry)

## save polygon sf object
usethis::use_data(large_polygon, overwrite = TRUE)

# small polygon crosses --------------------------------------------------------
small_polygon_geometry_crosses <- list(rbind(c(0, 2.5), c(0, 7.5), c(5, 7.5), c(5, 2.5), c(0, 2.5))) |>
  sf::st_polygon() |>
  sf::st_sfc(crs = "EPSG:27700")

# attribute field
attribute_field <- tibble::tibble(
  id = 2L,
  spatial = "crosses",
  `DE-9IM` = "212101212"
)

## polygon sf object
small_polygon_crosses <- sf::st_sf(attribute_field, geometry = small_polygon_geometry_crosses)

## save polygon sf object
usethis::use_data(small_polygon_crosses, overwrite = TRUE)

# small polygon within --------------------------------------------------------
small_polygon_geometry_within <- list(rbind(c(10, 2.5), c(10, 7.5), c(15, 7.5), c(15, 2.5), c(10, 2.5))) |>
  sf::st_polygon() |>
  sf::st_sfc(crs = "EPSG:27700")

# attribute field
attribute_field <- tibble::tibble(
  id = 3L,
  spatial = "within",
  `DE-9IM` = "2FF1FF212"
)

## polygon sf object
small_polygon_within <- sf::st_sf(attribute_field, geometry = small_polygon_geometry_within)

## save polygon sf object
usethis::use_data(small_polygon_within, overwrite = TRUE)

# small polygon touches --------------------------------------------------------
small_polygon_geometry_touches <- list(rbind(c(20, 2.5), c(20, 7.5), c(25, 7.5), c(25, 2.5), c(20, 2.5))) |>
  sf::st_polygon() |>
  sf::st_sfc(crs = "EPSG:27700")

# attribute field
attribute_field <- tibble::tibble(
  id = 4L,
  spatial = "touches",
  `DE-9IM` = "FF2F11212"
)

## polygon sf object
small_polygon_touches <- sf::st_sf(attribute_field, geometry = small_polygon_geometry_touches)

## save polygon sf object
usethis::use_data(small_polygon_touches, overwrite = TRUE)

# small polygon outside --------------------------------------------------------
small_polygon_geometry_outside <- list(rbind(c(30, 2.5), c(30, 7.5), c(35, 7.5), c(35, 2.5), c(30, 2.5))) |>
  sf::st_polygon() |>
  sf::st_sfc(crs = "EPSG:27700")

# attribute field
attribute_field <- tibble::tibble(
  id = 5L,
  spatial = "outside",
  `DE-9IM` = "FF2FF1212"
)

## polygon sf object
small_polygon_outside <- sf::st_sf(attribute_field, geometry = small_polygon_geometry_outside)

## save polygon sf object
usethis::use_data(small_polygon_outside, overwrite = TRUE)

# small polygons ---------------------------------------------------------------
small_polygons <- dplyr::bind_rows(small_polygon_crosses,
                                   small_polygon_within,
                                   small_polygon_touches,
                                   small_polygon_outside)

## save polygon sf object
usethis::use_data(small_polygons, overwrite = TRUE)

# points -----------------------------------------------------------------------
points <- tibble::tibble(
  id = 1:8,
  x = c(2.5, 5.5, 12.5, 15.5, 22.5, 25.5, 32.5, 35.5),
  y = c(5, 5, 5, 5, 5, 5, 5, 5)
) |>
  sf::st_as_sf(coords = c("x", "y")) |>
  sf::st_set_crs("EPSG:27700")

## save points sf object
usethis::use_data(points, overwrite = TRUE)

# spatial filtering ------------------------------------------------------------

## crosses ------------------------------------
small_polygons |>
  sf::st_filter(large_polygon, .predicate = sf::st_relate, pattern = "TTT******")

## within -------------------------------------
small_polygons |>
  sf::st_filter(large_polygon, .predicate = sf::st_relate, pattern = "TFF******")

### sf::st_within(small_polygons, large_polygon, sparse = FALSE)
small_polygons |>
  sf::st_filter(large_polygon, .predicate = sf::st_within)

## touches ------------------------------------
small_polygons |>
  sf::st_filter(large_polygon, .predicate = sf::st_relate, pattern = "FFT******")

### sf::st_touches(small_polygons, large_polygon, sparse = FALSE)
small_polygons |>
  sf::st_filter(large_polygon, .predicate = sf::st_touches)

### intersects [crosses, within, touches] ------
### sf::st_intersects(small_polygons, large_polygon, sparse = FALSE)
small_polygons |>
  sf::st_filter(large_polygon, .predicate = sf::st_intersects)

## outside within a defined distance -----------
### sf::st_distance(small_polygons, large_polygon, sparse = FALSE)
### sf::st_is_within_distance(small_polygons, large_polygon, dist = 10, sparse = FALSE)
small_polygons |>
  sf::st_filter(large_polygon, .predicate = sf::st_is_within_distance, dist = 10)

## outside -------------------------------------
### sf::st_disjoint(small_polygons, large_polygon, sparse = FALSE)
small_polygons |>
  sf::st_filter(large_polygon, .predicate = sf::st_disjoint)

# spatial intersection ---------------------------------------------------------
small_polygons |>
  sf::st_intersection(large_polygon) %>%
  dplyr::filter(sf::st_geometry_type(.) == "POLYGON") |>
  dplyr::select(-tidyselect::ends_with(".1"))

# spatial joins ----------------------------------------------------------------
points |>
  sf::st_join(small_polygons, join = sf::st_intersects, suffix = c("", ".1")) |>
  dplyr::select(-tidyselect::ends_with(".1"), -`DE-9IM`)

points |>
  sf::st_join(small_polygons, join = sf::st_is_within_distance, dist = 2, suffix = c("", ".1")) |>
  dplyr::select(-tidyselect::ends_with(".1"), -`DE-9IM`)

# export example geometries ----------------------------------------------------
sf::write_sf(large_polygon, "C:/Users/Graham French/Desktop/example/large_polygon.shp")
sf::write_sf(small_polygon_crosses, "C:/Users/Graham French/Desktop/example/small_polygon_crosses.shp")
sf::write_sf(small_polygon_within, "C:/Users/Graham French/Desktop/example/small_polygon_within.shp")
sf::write_sf(small_polygon_touches, "C:/Users/Graham French/Desktop/example/small_polygon_touches.shp")
sf::write_sf(small_polygon_outside, "C:/Users/Graham French/Desktop/example/small_polygon_outside.shp")
sf::write_sf(small_polygons, "C:/Users/Graham French/Desktop/example/small_polygons.shp")
sf::write_sf(points, "C:/Users/Graham French/Desktop/example/points.shp")
