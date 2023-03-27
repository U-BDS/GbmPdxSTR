#NOTE: the standards file was transformed into "long" since that's how the data is provided by Heflin
# (less error prone for users wanting to add in new references in the future)
# From this long file, we further modify with the following steps:

#----- remove homozygous values of alleles since we do not want that affecting the scoring methods -----

gbmpdx_ref <- read.csv("../data/initial_data_prep/STR_GBM_PDX_Standards_homozygous_str_loci.csv", colClasses = "character")

head(gbmpdx_ref)
tail(gbmpdx_ref)

gbmpdx_ref <- as.data.frame(t(apply(gbmpdx_ref, 1, function(x) replace(x, duplicated(x), NA))))

head(gbmpdx_ref)
tail(gbmpdx_ref)

# make all cols character (but if re-import, need to import as character...) #TODO: will save data as R objects

gbmpdx_ref <- mutate_all(gbmpdx_ref, as.character)

write.csv(gbmpdx_ref, "../data/STR_GBM_PDX_Standards.csv", row.names = FALSE)

#------ unite allele values -------
#NOTE: for this app we will keep the data.frame in the same format as CLASTR

# remove NAs prior to uniting

gbmpdx_ref <- tidyr::unite(gbmpdx_ref, STR_data, -GBM, -Marker, remove = TRUE, na.rm = TRUE, sep = ",")

#------ change layout to wide -----
gbmpdx_ref <- tidyr::pivot_wider(gbmpdx_ref, names_from = Marker, values_from = STR_data)

# now re-add NAs for any STRs where there is no data
gbmpdx_ref[gbmpdx_ref==""] <- NA

gbmpdx_ref

write.csv(gbmpdx_ref, "../data/STR_GBM_PDX_Standards_wide.csv", row.names = FALSE)

#------ save as data to be part of the package dataset -----

usethis::use_data(gbmpdx_ref, version = 3)
