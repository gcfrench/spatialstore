# large raster layer one -------------------------------------------------------
large_raster_layer_one <- terra::rast(nrows = 10, ncols = 10,
                                      xmin = -50, xmax = 50, ymin = -50, ymax = 50,
                                      crs = "EPSG:27700",
                                      vals = 1:100,
                                      nlyrs = 1, names = c("layer_1"))

# large raster layer two -------------------------------------------------------
large_raster_layer_two <- terra::rast(nrows = 10, ncols = 10,
                                      xmin = -50, xmax = 50, ymin = -50, ymax = 50,
                                      crs = "EPSG:27700",
                                      vals = 101:200,
                                      nlyrs = 1, names = c("layer_2"))

# large raster layer three -----------------------------------------------------
large_raster_layer_three <- terra::rast(nrows = 10, ncols = 10,
                                        xmin = -50, xmax = 50, ymin = -50, ymax = 50,
                                        crs = "EPSG:27700",
                                        vals = 201:300,
                                        nlyrs = 1, names = c("layer_3"))

# large raster_layers ----------------------------------------------------------
large_raster <- c(large_raster_layer_one,
                  large_raster_layer_two,
                  large_raster_layer_three)

## save SpatRaster object
# usethis::use_data(large_raster, overwrite = TRUE)

# small raster layer
small_raster <- terra::rast(nrows = 4, ncols = 12,
                            xmin = 0, xmax = 30, ymin = 0, ymax = 10,
                            crs = "EPSG:27700",
                            vals = 1:48,
                            nlyrs = 1, names = c("layer_1"))

## save SpatRaster object
# usethis::use_data(small_raster, overwrite = TRUE)

# Raster subsetting ------------------------------------------------------------

## subset using row and column numbers
large_raster |>
  terra::values(row = 5, nrow = 1, col = 6, ncols = 3, dataframe = TRUE)

# subset using cell coordinates
large_raster |>
  terra::extract(matrix(c(2.5, 2.5), ncol = 2))

# subset using another raster
large_raster[small_raster] # data frame output
large_raster[small_raster, drop = FALSE] # raster output

# subset using raster mask

## create raster mask with same extent and cell values = TRUE
mask_raster <- large_raster[["layer_1"]]
mask_raster[] <- NA
mask_raster[46:48] <- TRUE

## subset raster with mask raster
large_raster |>
  terra::mask(mask_raster)

# map algebra

# export example raster layers -------------------------------------------------
terra::writeRaster(large_raster, "C:/Users/Graham French/Desktop/example/large_raster.tif")
terra::writeRaster(small_raster, "C:/Users/Graham French/Desktop/example/small_raster.tif")
terra::writeRaster(mask_raster, "C:/Users/Graham French/Desktop/example/mask_raster.tif")

terra::writeRaster(x, "C:/Users/Graham French/Desktop/example/x.tif")
