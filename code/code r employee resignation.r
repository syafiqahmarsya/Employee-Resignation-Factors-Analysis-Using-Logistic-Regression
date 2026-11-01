Install Package 
library(dplyr) 
 
install.packages('car') # Install the car package 
library(car) # Load the car package 
 
# Install the gmodels package 
install.packages("gmodels") 
 
# Load the gmodels package 
library(gmodels) 
 
install.packages("pROC") 
library(pROC) 
 
install.packages("ResourceSelection") 
library(ResourceSelection) 
 
Loading Data 
url <- "https://raw.githubusercontent.com/Miyaputri/ADK/main/HR.csv" 
HR <- read.csv(url) 
head(HR) 
 
Preprocessing 
summary(HR) 
 
# Cek tipe data 
str(HR) 
 
# Ordinal encoding untuk salary (misalnya berdasarkan urutan tertentu) 
HR$salary <- factor(HR$salary, levels = c("low", "medium", "high"), ordered = 
TRUE) 
HR$salary_encoded <- as.numeric(HR$salary) 
HR$salary_encoded 
 
# Mengubah variabel sales dari kategorik menjadi numerik 
HR$sales_encoded <- as.numeric(factor(HR$sales)) 
HR$sales_encoded 
 
#menghapus variabel sales dan salary 
HR <- HR %>% dplyr::select(-sales, -salary) 
head(HR) 
 
str(HR) 
 
# Uji Chi-Square untuk variabel kategorik 
cat("=== Uji Chi-Square untuk variabel kategorik ===\n") 
 
# Variabel kategorik 
categorical_vars <- c("salary_encoded", "sales_encoded", "Work_accident", 
"promotion_last_5years") 
 
for (var in categorical_vars) { 
  cat("Uji Chi-Square antara 'left' dan", var, "\n") 
  chisq_res <- chisq.test(table(HR$left, HR[[var]])) # Tabel kontingensi 
  print(chisq_res) 
  cat("\n-------------------------------------\n") 
} 
 
# Uji t-Test untuk variabel numerik 
cat("\n=== Uji t-Test untuk variabel numerik ===\n") 
 
# Variabel numerik 
numeric_vars <- c("satisfaction_level", "last_evaluation", 
                  "number_project", "average_montly_hours", 
"time_spend_company") 
 
for (var in numeric_vars) { 
  cat("Uji t-Test antara 'left' dan", var, "\n") 
  ttest_res <- t.test(HR[[var]] ~ HR$left) 
  print(ttest_res) 
  cat("\n-------------------------------------\n") 
} 
 
Model 
HR_model<-glm(formula = left ~ satisfaction_level + number_project + 
average_montly_hours + time_spend_company+ Work_accident + 
promotion_last_5years + sales_encoded + salary_encoded,data = HR, 
family=binomial) 
summary(HR_model) 
 
HR_model1 <-glm(formula = left ~ satisfaction_level + number_project + 
average_montly_hours + time_spend_company+ Work_accident + 
promotion_last_5years + salary_encoded,data = HR, family=binomial) 
summary(HR_model) 
 
# cek multikolinearitas model sebelum model asumsi 
vif(HR_model1) 
 
HR_model2<-glm(formula = left ~ satisfaction_level + number_project + 
average_montly_hours + time_spend_company+ 
as.factor(Work_accident)+as.factor(promotion_last_5years)+as.factor(salary_enc
oded),data = HR, family=binomial) 
summary(HR_model2) 
 
# cek multikolinearitas model sebelum model asumsi 
vif(HR_model2) 
 
anova(HR_model1, HR_model2, test = "Chisq") 
 
Asumsi Model dengan Interaksi 
HR_model3 <- glm( 
  formula = left ~ satisfaction_level + 
    number_project + 
    average_montly_hours + 
    time_spend_company + 
    as.factor(Work_accident) + 
    as.factor(salary_encoded)+ 
    as.factor(promotion_last_5years) + 
    as.factor(salary_encoded) * as.factor(promotion_last_5years) + 
    satisfaction_level * as.factor(salary_encoded) + 
    time_spend_company * as.factor(promotion_last_5years) + 
    satisfaction_level * average_montly_hours, 
  data = HR, 
  family = binomial 
) 
 
 
summary(HR_model3) 
 
vif(HR_model3) 
 
HR_model2.step <- step(HR_model2, direction = "backward", trace = TRUE) 
summary(HR_model2.step) 
 
HR_model3.step <- step(HR_model3, direction = "backward", trace = TRUE) 
summary(HR_model3.step) 
 
Model Terbaik 
anova(HR_model2.step, HR_model3.step, test = "Chisq") 
 
summary(HR_model3.step) 
 
HR_model3.step.hs <- hoslem.test(HR$left, fitted(HR_model3.step),g = 10) 
HR_model3.step.hs 
 
yhat <- fitted(HR_model3.step)  # Mendapatkan prediksi peluang 
pred_50 <- ifelse(yhat >= 0.50, 1, 0)  # Prediksi 0/1, dengan threshold 0.50 
 
# Membuat dataframe untuk membandingkan prediksi dan data asli 
classify <- as.data.frame(cbind(pred_50, case = HR$left))  # Prediksi dan data 
asli 
 
# Menampilkan tabel klasifikasi menggunakan CrossTable 
CrossTable(classify$pred_50, classify$case, 
           dnn = c("Predicted (cut = .50)", "Observed"), 
           format = "SAS", 
           prop.r = FALSE, prop.c = FALSE, prop.t = FALSE, 
           prop.chisq = FALSE, chisq = FALSE, fisher = FALSE) 
 
# Hitung probabilitas prediksi untuk model 
yhat <- fitted(HR_model3.step) 
 
# Membuat ROC curve 
roc1 <- roc(HR$left, yhat) 
 
# Plot ROC curve 
plot.roc(roc1, main = "ROC Curve", print.auc = TRUE, legacy.axes = TRUE) 
 
Model Terbaik 
summary(HR_model3.step)
