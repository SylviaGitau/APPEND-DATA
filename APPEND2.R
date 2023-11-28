library(dplyr)
sth_data <- read_excel("C:\Users\sylvia.gitau_evidenc\Documents\Evidence Docs\Kenya Treatment Dashboard\2023 Cleaned STH number (1).xlsx")
View(sth_data)
sch_data <- read_excel("C:\Users\sylvia.gitau_evidenc\Documents\Evidence Docs\Kenya Treatment Dashboard\2023 Cleaned SCH number (1).xlsx")
View(sch_data)
form_517c <- read_csv("C:\Users\sylvia.gitau_evidenc\Documents\Evidence Docs\Kenya Treatment Dashboard\form_517c (1) (1).csv")
View(form_517c)

# Define the column name mappings
column_mappings <- c("c_sch_name" = "a_sch_name", 
                     "c_2_f" = "a_2_f",
                     "c_sch" = "a_sch",
                     "c_2_m"="a_2_m",
                     "c_6_f"	="a_6_f",
                     "c_6_m"=	"a_6_m",
                     "c_15_m"=	"a_15_m",
                     "c_15_f"=	"a_15_f",
                     "c_alb_receive"=	"a_alb_rec",
                     "c_ecd_registered"=	"a_ecd_registered",
                     "source"="datasource",
                     "c_alb_return"="a_alb_return",
                     "c_ecd_trt_m" = "a_ecd_m",
                     "c_ecd_trt_f" = "a_ecd_f",
                     "c_ecd_trt_total" = "a_ecd_total",
                     "c_o5_m" = "a_o5_m",
                     "c_o5_f" = "a_o5_f",
                     "c_alb_spoilt"="a_alb_spoilt",
                     "c_enroll_trt_m" = "a_enroll_m",
                     "c_enroll_trt_f" = "a_enroll_f",
                     "c_enroll_trt_total" = "a_enroll_total",
                     "c_ne_trt_m" = "a_ne_m",
                     "c_ne_trt_f" = "a_ne_f",
                     "c_ne_trt_total"= "a_ne_total",
                     "c_u5_m" = "a_u5_m",
                     "c_u5_f" = "a_u5_f",
                     "c_u5_total" = "a_u5_total",
                     "c_o5_total" = "a_o5_total",
                     "c_2_total"="a_2_total",
                     "c_6_total"="a_6_total",
                     "c_15_total"="a_15_total",
                     "c_6_18_m"="a_6_18_m",
                     "c_6_18_f"="a_6_18_f",
                     "c_6_18_total"="a_6_18_total",
                     "c_2_14_m"="a_2_14_m",
                     "c_2_14_f"="a_2_14_f",
                     "c_2_14_total"="a_2_14_total",
                     "c_total_trt_m" = "a_total_m",
                     "c_total_trt_f" = "a_total_f",
                     "c_total_trt_child" = "a_total_child",
                     "c_pry_trt_m" = "a_trt_m",
                     "c_pry_trt_f" = "a_trt_f",
                     "c_alb_used"="a_alb_used",
                     "c_year"="year",
                     "c_pry_trt_total" = "a_trt_total",
                     "c_total_adult" = "a_total_adult",
                     "c_total_trt_all" = "a_total_all",
                     "c_pry_reg_tot + c_ecd_reg_tot" = "a_reg_total",
                     "cp_sch_name"="a_sch_name",
                     "cp_total_trt_m" = "ap_total_m",
                     "cp_enroll_trt_m" = "ap_enroll_m",
                     "cp_enroll_trt_f" = "ap_enroll_f",
                     "cp_ne_trt_m" = "ap_ne_m",
                     "cp_ne_trt_f" = "ap_ne_f",
                     "cp_ne_trt_total" = "ap_ne_total",
                     "cp_total_adult" = "ap_total_adult",
                     "cp_total_all" = "ap_total_all",
                     "cp_sch"="ap_sch",
                     "cp_enroll_trt_total"="ap_enroll_total",
                     "cp_6_m"="ap_6_m",
                     "cp_6_f"="ap_6_f",
                     "cp_6_total"="ap_6_total",
                     "cp_15_f"="ap_15_f",
                     "cp_15_m"="ap_15_m",
                     "cp_15_total"="ap_15_total",
                     "cp_ecd_registered + cp_pry_registered"="ap_reg_total",
                     "cp_total_adult"="ap_total_child",
                     "cp_total_trt_f"="ap_total_f",
                     "cp_pzq_used"="ap_pzq_used")

# Loop through the column mapping and rename columns in sch_data

for (col in names(sch_data)) {
  if (col %in% names(column_mappings) && !is.na(column_mappings[[col]])) {
    names(sch_data)[names(sch_data) == col] <- column_mappings[[col]]
  }
}

# Loop through the column mapping and rename columns in sth_data

for (col in names(sth_data)) {
  if (col %in% names(column_mappings) && !is.na(column_mappings[[col]])) {
    names(sth_data)[names(sth_data) == col] <- column_mappings[[col]]
  }
}

# Identify the columns in SCH and STH that are not in form_517c
columns_to_remove_sch <- setdiff(names(sch_data), names(form_517c))
columns_to_remove_sth <- setdiff(names(sth_data), names(form_517c))

# Remove the identified columns from SCH
sch_data <- sch_data %>%
  select(-one_of(columns_to_remove_sch))

# Remove the identified columns from STH
sth_data <- sth_data %>%
  select(-one_of(columns_to_remove_sth))

# remove datasource & a_sch_name
sch_data <- sch_data %>%
  select(-a_sch_name, -datasource)

# Append 
appended_data_sch <- rbind(sch_data, form_517c_1_sch)
appended_data_sth <- rbind(sth_data, form_517c_1_sth)

# export
write.csv(appended_data_sch, "append_sch.csv")
write.csv(appended_data_sth, "append_sth.csv")
