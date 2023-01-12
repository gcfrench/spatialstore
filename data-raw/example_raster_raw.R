# large raster layer one -------------------------------------------------------
large_raster_layer_one <- terra::rast(nrows = 1000, ncols = 1000,
                                      xmin = -5000, xmax = 5000, ymin = -5000, ymax = 5000,
                                      crs = "EPSG:27700",
                                      vals = 1:1000000,
                                      nlyrs = 1, names = c("layer_1"))

# large raster layer two -------------------------------------------------------
large_raster_layer_two <- terra::rast(nrows = 1000, ncols = 1000,
                                      xmin = -5000, xmax = 5000, ymin = -5000, ymax = 5000,
                                      crs = "EPSG:27700",
                                      vals = 1000001:2000000,
                                      nlyrs = 1, names = c("layer_2"))

# large raster layer three -----------------------------------------------------
large_raster_layer_three <- terra::rast(nrows = 1000, ncols = 1000,
                                        xmin = -5000, xmax = 5000, ymin = -5000, ymax = 5000,
                                        crs = "EPSG:27700",
                                        vals = 2000001:3000000,
                                        nlyrs = 1, names = c("layer_3"))

# large raster_layers ----------------------------------------------------------
large_raster_layers <- c(large_raster_layer_one,
                         large_raster_layer_two,
                         large_raster_layer_three)

## save SpatRaster object
# usethis::use_data(large_raster_layers, overwrite = TRUE)

# small raster layer
small_raster <- terra::rast(nrows = 300, ncols = 100,
                            xmin = 0, xmax = 3000, ymin = 0, ymax = 1000,
                            crs = "EPSG:27700",
                            vals = 1:30000,
                            nlyrs = 1, names = c("layer_1"))

## save SpatRaster object
# usethis::use_data(small_raster, overwrite = TRUE)

# Raster subsetting ------------------------------------------------------------
large_raster_layers |>
  terra::values(row = 500, nrow = 300, col = 500, ncols = 100, dataframe = TRUE)

# export example raster layers -------------------------------------------------
terra::writeRaster(large_raster_layers, "C:/Users/Graham French/Desktop/example/large_raster_layers.tif")
terra::writeRaster(small_raster, "C:/Users/Graham French/Desktop/example/small_raster.tif")

