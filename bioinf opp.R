setwd("C:/Users/user/Downloads")


data <- read.csv("GSE60450_GeneLevel_Normalized(CPM.and.TMM)_data.csv")


nrow(data)
ncol(data)


numeric_data <- data[, -1]


numeric_data[] <- lapply(numeric_data, function(x) as.numeric(as.character(x)))


sapply(numeric_data, class)


log_data <- log2(numeric_data + 1)


library(tidyr)
library(dplyr)
library(ggplot2)


long_data <- as.data.frame(log_data) %>%
  pivot_longer(
    cols = everything(),
    names_to = "Sample",
    values_to = "Expression"
  )


ggplot(long_data, aes(x = Sample, y = Expression)) +
  geom_boxplot() +
  theme_minimal() +
  labs(
    title = "Log2 Gene Expression Across Samples",
    x = "Sample",
    y = "Log2(CPM + 1)"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

