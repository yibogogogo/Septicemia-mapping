setwd('/Users/zhang/Library/Mobile Documents/com~apple~CloudDocs/工作文件/比较医学')

# 读取数据
checkpoint1 <- read.csv(file = '1记录.csv', header = TRUE, row.names = 1)
checkpoint2 <- read.csv(file = '2记录.csv', header = TRUE, row.names = 1)

# 创建分组注释
group_info <- data.frame(
  Group = rep(c("Sham", "Mild", "Severe"), times = c(5, 3, 3)),
  row.names = colnames(checkpoint1)
)

# 设置分组颜色
group_colors <- list(Group = c("Sham" = "#FDC086", "Mild" = "#7FC97F", "Severe" = "firebrick"))

# 将"NULL"转换为NA并确保数据类型正确
checkpoint2[checkpoint2 == "NULL"] <- NA
mat <- as.matrix(checkpoint2)

# 转换为数值矩阵 - 修复错误的关键步骤
mat_numeric <- apply(mat, 2, function(x) as.numeric(as.character(x)))
rownames(mat_numeric) <- rownames(mat)

# 创建自定义显示标签函数
custom_labels <- function(mat) {
  labels <- matrix("", nrow = nrow(mat), ncol = ncol(mat))
  for(i in 1:nrow(mat)) {
    for(j in 1:ncol(mat)) {
      if(!is.na(mat[i, j])) {
        labels[i, j] <- sprintf("%.0f", mat[i, j])
      }
    }
  }
  return(labels)
}

# 生成数值标签
number_labels <- custom_labels(mat_numeric)

# 绘制热图
library(pheatmap)
pheatmap(
  mat = mat_numeric,
  color = colorRampPalette(c("#F7FBFF", "#6BAED6", "#08306B"))(100),
  na_col = "gray90",  # NA值显示为浅灰色
  cluster_rows = FALSE,
  cluster_cols = FALSE,
  annotation_col = group_info,
  annotation_colors = group_colors,
  show_colnames = TRUE,
  border_color = "grey80",
  cellwidth = 25,
  cellheight = 20,
  fontsize_row = 10,
  fontsize_col = 9,
  main = "Murine sepsis score (MSS)",
  fontfamily = "Helvetica",
  
  # 数值标签设置 - 使用自定义标签
  display_numbers = number_labels,  # 使用预先生成的标签
  number_color = "black",
  fontsize_number = 8,
  
  # 图例设置
  legend_breaks = c(0, 1, 2, 3, 4),
  legend_labels = c("0", "1", "2", "3", "4")
)




