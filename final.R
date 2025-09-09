# -----------------------------------------
# Project: Data Cleaning / Preprocessor (R)
# -----------------------------------------

# --- Ensure required packages are available ---
required_pkgs <- c("readr", "dplyr", "ggplot2")
for (p in required_pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) install.packages(p)
}
library(readr)
library(dplyr)
library(ggplot2)

# 1) Load data (CSV)
data <- read_csv("data.csv", show_col_types = FALSE)

# 2) Display BEFORE cleaning
print("Data before cleaning:")
print(data)

print("Data summary before cleaning:")
print(summary(data))

# --- Create histograms BEFORE cleaning (lighter colors) ---
# Age
ggplot(data, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black", alpha = 0.7) +
  ggtitle("Age Distribution (Before Cleaning)") +
  theme_minimal()
ggsave("age_before.png")

# Annual Salary
ggplot(data, aes(x = Annual_Salary)) +
  geom_histogram(binwidth = 5000, fill = "skyblue", color = "black", alpha = 0.7) +
  ggtitle("Annual Salary Distribution (Before Cleaning)") +
  theme_minimal()
ggsave("salary_before.png")

# 3) Fill missing values
#    - Numeric: mean
#    - Non-numeric: mode
for (col in names(data)) {
  if (is.numeric(data[[col]])) {
    mean_value <- mean(data[[col]], na.rm = TRUE)
    data[[col]][is.na(data[[col]])] <- mean_value
  } else {
    uniq <- na.omit(unique(data[[col]]))
    mode_value <- uniq[which.max(tabulate(match(data[[col]], uniq)))]
    data[[col]][is.na(data[[col]])] <- mode_value
  }
}

# 4) Remove duplicates
data <- data %>% distinct()

# 5) Categorize selected numeric columns by median (Low/High)
columns_to_categorize <- c("Age", "Annual_Salary")

for (col in columns_to_categorize) {
  if (!col %in% names(data)) next
  median_value <- median(data[[col]], na.rm = TRUE)
  new_col <- paste0(col, "_Group")
  data[[new_col]] <- dplyr::case_when(
    data[[col]] <  median_value ~ "Low",
    data[[col]] >= median_value ~ "High",
    .default = "Unknown"
  )
}

# 6) Factorize selected columns
columns_to_factorize <- c("Gender", "Purchased_Product", "Age_Group", "Annual_Salary_Group")
for (col in columns_to_factorize) {
  if (!col %in% names(data)) next
  data[[col]] <- factor(data[[col]])
}

# 7) Display AFTER cleaning
print("Data after cleaning:")
print(data)

print("Data summary after cleaning:")
print(summary(data))

# --- Create histograms AFTER cleaning (lighter colors) ---
# Age
ggplot(data, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "lightgreen", color = "black", alpha = 0.7) +
  ggtitle("Age Distribution (After Cleaning)") +
  theme_minimal()
ggsave("age_after.png")

# Annual Salary
ggplot(data, aes(x = Annual_Salary)) +
  geom_histogram(binwidth = 5000, fill = "lightgreen", color = "black", alpha = 0.7) +
  ggtitle("Annual Salary Distribution (After Cleaning)") +
  theme_minimal()
ggsave("salary_after.png")

# 8) Write cleaned CSV
readr::write_csv(data, "cleaned_data.csv")
print('Cleaning complete. File saved as "cleaned_data.csv".')
