os <- read.csv(file = 'os.csv', header = TRUE, row.names = 1)
surv_data <- os

# 创建数据框
surv_data <- data.frame(
  group = c(rep("Sham", 6), rep("Mild", 3), rep("Severe", 3)),
  death = c(0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1),
  time = c(24, 24, 24, 0, 24, 24, 24, 24, 24, 24, 7, 23)
)

# 查看数据结构
head(surv_data)

library(survival)
library(survminer)
library(ggplot2)

# 创建生存对象
surv_obj <- Surv(time = surv_data$time, event = surv_data$death)

# 按组拟合Kaplan-Meier曲线
fit <- survfit(surv_obj ~ group, data = surv_data)

# 创建美观的生存曲线图
ggsurvplot(
  fit, 
  data = surv_data,
  pval = TRUE,          # 显示log-rank检验p值
  conf.int = F,      # 显示置信区间
  palette = c("#FDC086", "#7FC97F", "firebrick"),  # 自定义颜色
  xlab = "Time (Hours)", # 时间轴标签
  ylab = "Survival Probability", # 生存概率标签
  legend.title = "Group", # 图例标题
  legend.labs = c("Sham", "Mild", "Severe"), # 图例标签
  risk.table = TRUE,    # 显示风险表
  ggtheme = theme_minimal(), # 使用简洁主题
  break.time.by = 4,    # 时间轴刻度间隔
  censor.shape = "|",   # 删失标记形状
  censor.size = 4,      # 删失标记大小
  surv.plot.height = 0.7 # 生存图高度比例
)
