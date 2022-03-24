# remove homozygous values of alleles since we do not want that affecting the scoring methods

gbmpdx_ref <- read.csv("./data/initial_data_prep/STR_GBM_PDX_Standards_homozygous_str_loci.csv")

head(gbmpdx_ref)
tail(gbmpdx_ref)

gbmpdx_ref <- as.data.frame(t(apply(gbmpdx_ref, 1, function(x) replace(x, duplicated(x), NA))))

head(gbmpdx_ref)
tail(gbmpdx_ref)

write.csv(gbmpdx_ref, "./data/STR_GBM_PDX_Standards.csv", row.names = FALSE)
