# pre-prep

wq <- read.csv(file.path('data_raw', wq_file), na.strings = c("", "NA"), stringsAsFactors = F, strip.white = TRUE)

str(wq)

# remove commas from columns
wq$runoff_volume <- as.numeric(gsub(',', '', wq$runoff_volume))
wq$suspended_sediment_load_pounds <- as.numeric(gsub(',', '', wq$suspended_sediment_load_pounds))
no2_replace <- 0.5*min(wq$no2_no3_n_load_pounds[wq$no2_no3_n_load_pounds != 0])
amm_replace <- 0.5*min(wq$ammonium_n_load_pounds[wq$ammonium_n_load_pounds != 0])
ortho_replace <- 0.5*min(wq$orthophosphate_load_pounds[wq$orthophosphate_load_pounds != 0])

wq$no2_no3_n_load_pounds <- ifelse(wq$no2_no3_n_load_pounds == 0, no2_replace, wq$no2_no3_n_load_pounds)
wq$ammonium_n_load_pounds <- ifelse(wq$ammonium_n_load_pounds == 0, amm_replace, wq$ammonium_n_load_pounds)
wq$orthophosphate_load_pounds <- ifelse(wq$orthophosphate_load_pounds == 0, ortho_replace, wq$orthophosphate_load_pounds)

write.csv(wq, 'data_raw/prepped_wq_bystorm.csv', row.names = F)

other_vars <- read.csv(file.path('data_raw', weather_file))
other_vars <- mutate(other_vars, 
                     date = as.Date(`Timestamp..UTC.05.00.`, format = datetime_format))
write.csv(other_vars, 'data_raw/prepped_weather_othervars.csv', row.names = F)
