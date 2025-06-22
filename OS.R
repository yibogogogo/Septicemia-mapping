os <- read.csv(file = 'os.csv', header = TRUE, row.names = 1)

# 方法：单独计算每个组的生存曲线
fit_list <- list(
  Sham = survfit(Surv(Time, Status) ~ 1, 
                 data = survival_data %>% filter(Group == "Sham")),
  Mild = survfit(Surv(Time, Status) ~ 1, 
                 data = survival_data %>% filter(Group == "Mild")),
  Severe = survfit(Surv(Time, Status) ~ 1, 
                   data = survival_data %>% filter(Group == "Severe"))
)

# 手动合并生存曲线
ggsurvplot_combine(
  fit_list,
  data = survival_data,
  palette = c("#FDC086", "#7FC97F", "firebrick"),
  linetype = c(1, 1, 1),
  legend.title = "Group",
  legend.labs = c("Sham", "Mild", "Severe"),
  risk.table = TRUE,
  title = "Survival Analysis by Group"
)

