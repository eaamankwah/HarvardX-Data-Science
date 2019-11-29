# install and import libraries
library(dplyr)
library(tidyverse)
library(readr)
library(e1071)
library(mlr)
library(caret)
library(caretEnsemble)
library(DataExplorer)
library(MASS)
library(rpart)# For classification model
library(randomForest)
library(gridExtra) # To plot several plots in one figur
library(knitr)
library(corrplot)
library(klaR)
library(xgboost)
library(matrixStats)
library(fastAdaboost)
library(earth)
library(ggthemes)
library(cowplot)
library(Rmisc)
options(digits = 3)

#Data Pre-processing for Data Exploration
# proccessed data were combined and the header named
cleveland <- read.csv('processed.cleveland.csv', na = "?", stringsAsFactors = FALSE, header = FALSE)
hungarian <- read.csv('processed.hungarian.csv', na = "?", stringsAsFactors = FALSE, header = FALSE)
switzerland <- read.csv('processed.switzerland.csv', na = "?", stringsAsFactors = FALSE, header = FALSE)
va <- read.csv('processed.va.csv', na = "?", stringsAsFactors = FALSE, header = FALSE)
hdisease <- rbind(cleveland, hungarian, switzerland, va)
names(hdisease) <- c('Age', 'Sex', 'CP', 'Trestbps', 'Chol', 'FBS', 'RestECG',
                 'Thalach', 'Exang', 'Oldpeak', 'Slope', 'CA', 'Thal', 'Target')

#str(hdisease)
#Missing values
plot_missing(hdisease)

#dropping high na columns and rows with nas
drops <- c("Slope","CA", "Thal")
hd <- hdisease[ , !(names(hdisease) %in% drops)]
#str(hd)
hd <- na.omit(hd)

hd$Target[hd$Target == 0] <- "N"
hd$Target[hd$Target == 1] <- "Y"
hd$Target[hd$Target == 2] <- "Y"
hd$Target[hd$Target == 3] <- "Y"
hd$Target[hd$Target == 4] <- "Y"

hd1 <- hd

#str(hd)
na.omit(hd)
hd$Target <- as.factor(hd$Target)
#str(hd)

## Visualize the importance of variables using featurePlot() for boxplot
featurePlot(x = hd[,1:10], 
            y = hd$Target, 
            plot = "box",
            strip=strip.custom(par.strip.text=list(cex=.7)),
            scales = list(x = list(relation="free"), 
                          y = list(relation="free")))

## visualize the importance of variables using featurePlot() for density
# watch for height (kurtosis) and placement (skewness).
featurePlot(x = hd[,1:10], 
            y = hd$Target, 
            plot = "density",
            strip=strip.custom(par.strip.text=list(cex=.7)),
            scales = list(x = list(relation="free"), 
                          y = list(relation="free")))

# Data Exploration
## Variable correlation plot
hd_correlation <- cor(hd[,-c(11)])
corrplot(hd_correlation,
         order = 'hclust',
         tl.cex = 0.8,
         addrect = 8)

# Highly correlated variable 
# summarize the correlation matrix
print(hd_correlation)
# find attributes that are highly corrected (ideally >0.75)
top_hd_cor <- findCorrelation(hd_correlation, cutoff=0.25)

# print indexes of highly correlated attributes
print("Top Correlation Feature",top_hd_cor)
top_hd_cor

hd_correlation[c(1,8,9,10),c(1,8,9,10)] %>% knitr::kable( caption = 'Top Correlated Features')

#Data transformation
hd_trans <- hdisease %>% 
  mutate(Sex = if_else(Sex == 1, "MALE", "FEMALE"),
         FBS = if_else(FBS == 1, ">120", "<=120"),
         CP = if_else(CP == 1, "ATYPICAL ANGINA",
                      if_else(CP == 2, "NON-ANGINAL PAIN", "ASYMPTOMATIC")),
         RestECG = if_else(RestECG == 0, "NORMAL",
                           if_else(RestECG == 1, "ABNORMALITY", "PROBABLE OR DEFINITE")),
         Exang = if_else(Exang == 1, "YES", "NO"),
         Target = if_else(Target == 1, "Y", "N")) %>% 
  mutate_if(is.character, as.factor) %>% 
  dplyr::select(Target, Sex, FBS, CP,RestECG, Exang, everything())

hd_trans <- na.omit(hd_trans)
#str(hd_trans)

#Univariate analysis
#Univariate plot

g1 <- ggplot(hd_trans, aes(x = Age)) +
                           geom_histogram(stat="count",fill = "cornflowerblue",
                                          color = "red") +
                           labs(title="Participants by Age",
                                x = "Age")+theme(axis.text.x = element_text(angle = 45, hjust = 1))
g2 <- ggplot(hd_trans, aes(x = Sex)) +
                           geom_histogram(stat="count",fill = "cornflowerblue",
                                          color = "red") +
                           labs(title="Participants by Sex",
                                x = "Sex")+theme(axis.text.x = element_text(angle = 45, hjust = 1))
g3 <- ggplot(hd_trans, aes(x = CP)) +
                           geom_histogram(stat="count",fill = "cornflowerblue",
                                          color = "red") +
                           labs(title="Participants by Chest Pain",
                                x = "CP")+theme(axis.text.x = element_text(angle = 45, hjust = 1))
g4 <- ggplot(hd_trans, aes(x = Trestbps)) +
                           geom_histogram(stat="count",fill = "cornflowerblue",
                                          color = "red") +
                           labs(title="Participants by Resting Blood Pressure",
                                x = "Trestpbs")+theme(axis.text.x = element_text(angle = 45, hjust = 1))
g5 <- ggplot(hd_trans, aes(x = Chol)) +
                           geom_histogram(stat="count",fill = "cornflowerblue",
                                          color = "red") +
                           labs(title="Participants by Cholestrol",
                                x = "Chol")+theme(axis.text.x = element_text(angle = 45, hjust = 1))
g6 <- ggplot(hd_trans, aes(x = FBS)) +
                           geom_histogram(stat="count",fill = "cornflowerblue",
                                          color = "red") +
                           labs(title="Participants by Fasting Blood Sugar",
                                x = "FBS")+theme(axis.text.x = element_text(angle = 45, hjust = 1))
g7 <- ggplot(hd_trans, aes(x = RestECG)) +
                           geom_histogram(stat="count",fill = "cornflowerblue",
                                          color = "red") +
                           labs(title="Participants by resting electrocardiogram",
                                x = "RestECG")+theme(axis.text.x = element_text(angle = 45, hjust = 1))
g8 <- ggplot(hd_trans, aes(x = Thalach)) +
                           geom_histogram(stat="count",fill = "cornflowerblue",
                                          color = "red") +
                           labs(title="Participants by Maximum Heat Rate",
                                x = "Thalach")+theme(axis.text.x = element_text(angle = 45, hjust = 1))
g9 <- ggplot(hd_trans, aes(x = Exang)) +
                           geom_histogram(stat="count",fill = "cornflowerblue",
                                          color = "red") +
                           labs(title="Participants by Exercise Induced Angina",
                                x = "Exang")+theme(axis.text.x = element_text(angle = 45, hjust = 1))
g10 <-  ggplot(hd_trans, aes(x = Oldpeak)) +
                           geom_histogram(stat="count",fill = "cornflowerblue",
                                          color = "red") +
                           labs(title="Participants by ST Depression Induced by Exercise",
                                x = "Oldpeak")+theme(axis.text.x = element_text(angle = 45, hjust = 1))

layout <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10), nrow = 5, byrow = TRUE)
multiplot(g1, g2, g3, g4, g5, g6, g7, g8, g9, g10,layout = layout )

#Bivariate Distribution
##Variable Distribution with Target
p1 <- hd_trans %>% ggplot(aes(Age, fill = Target))+
  geom_bar(position = "dodge2")+
  theme_classic()+theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  scale_fill_manual(values = c("#4682B4","#A9A9A9"))
p2 <- hd_trans %>% ggplot(aes(Sex, fill = Target))+
  geom_bar(position = "dodge2")+
  theme_classic()+theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  scale_fill_manual(values = c("#4682B4","#A9A9A9"))
p3 <- hd_trans %>% ggplot(aes(CP, fill = Target))+
  geom_bar(position = "dodge2")+
  theme_classic()+theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  scale_fill_manual(values = c("#4682B4","#A9A9A9"))
p4 <- hd_trans %>% ggplot(aes(Trestbps, fill = Target))+
  geom_bar(position = "dodge2")+
  theme_classic()+theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  scale_fill_manual(values = c("#4682B4","#A9A9A9"))
p5 <- hd_trans %>% ggplot(aes(Chol, fill = Target))+
  geom_bar(position = "dodge2")+
  theme_classic()+theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  scale_fill_manual(values = c("#4682B4","#A9A9A9"))
p6 <- hd_trans %>% ggplot(aes(FBS, fill = Target))+
  geom_bar(position = "dodge2")+
  theme_classic()+theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  scale_fill_manual(values = c("#4682B4","#A9A9A9"))
p7 <- hd_trans %>% ggplot(aes(RestECG, fill = Target))+
  geom_bar(position = "dodge2")+
  theme_classic()+theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  scale_fill_manual(values = c("#4682B4","#A9A9A9"))
p8 <- hd_trans %>% ggplot(aes(Thalach, fill = Target))+
  geom_bar(position = "dodge2")+
  theme_classic()+theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  scale_fill_manual(values = c("#4682B4","#A9A9A9"))
p9 <- hd_trans %>% ggplot(aes(Exang, fill = Target))+
  geom_bar(position = "dodge2")+
  theme_classic()+theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  scale_fill_manual(values = c("#4682B4","#A9A9A9"))
p10 <- hd_trans %>% ggplot(aes(Oldpeak, fill = Target))+
  geom_bar(position = "dodge2")+
  theme_classic()+theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  scale_fill_manual(values = c("#4682B4","#A9A9A9"))
#grid.arrange(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10,vp, nrow=5, heights = c(.35,.65,.35,.65,.35),fontsize = 9)
#plot_grid(p1, NULL,p2, NULL,p3,NULL,p4, NULL,p5, NULL,p6,NULL, p7, NULL,p8,NULL,p9, NULL,p10, ncol = 3, scale = 0.7)
layout <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10), nrow = 5, byrow = TRUE)
multiplot(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10,layout = layout )

## Variation of sex and age
hist_age <- ggplot(hd_trans, aes(Age, fill = Sex))+
  geom_histogram(bins = 30, position = 'stack', color="black")+theme_classic()+
  scale_color_brewer(palette = "Accent")+
  scale_fill_brewer(palette = "Accent")+
  labs(title = "Histogram of age variable with sex", x = "age", y = "count")
hist_age

## Categorical Features
### Variation of Sex, Chest pain, FBS and RestECG with Target
bar_graph1 <- grid.arrange(ggplot(hd_trans, aes(x = Sex, fill = Target))+geom_bar(position = "fill")+
                             theme(axis.text.x = element_text(angle = 45, hjust = 1)),
                           ggplot(hd_trans, aes(x = CP, fill = Target))+geom_bar(position = "fill")+
                             theme(axis.text.x = element_text(angle = 45, hjust = 1)),
                           ggplot(hd_trans, aes(x = FBS, fill = Target))+geom_bar(position = "fill")+
                             theme(axis.text.x = element_text(angle = 45, hjust = 1)),
                           ggplot(hd_trans, aes(x = Exang, fill = Target))+geom_bar(position = "fill")+
                             theme(axis.text.x = element_text(angle = 45, hjust = 1)),
                           ggplot(hd_trans, aes(x = RestECG, fill = Target))+geom_bar(position = "fill")+
                             theme(axis.text.x = element_text(angle = 45, hjust = 1)))


#Numerical Features
### Variation of Trestbps, Age, Chol, Thalach, Exang and Oldpeak with Target
bar_graph2 <- grid.arrange(ggplot(hd_trans, aes(x = Trestbps, fill = Target))+geom_bar(position = "fill")+
                             theme(axis.text.x = element_text(angle = 45, hjust = 1)),
                           ggplot(hd_trans, aes(x = factor(Age), fill = Target))+geom_bar(position = "fill")+
                             labs(x= "Age") +theme(axis.text.x = element_text(angle = 45, hjust = 1)),
                           ggplot(hd_trans, aes(x = Chol, fill = Target))+geom_bar(position = "fill")+
                             theme(axis.text.x = element_text(angle = 45, hjust = 1)),
                           ggplot(hd_trans, aes(x = Thalach, fill = Target))+geom_bar(position = "fill")+
                             theme(axis.text.x = element_text(angle = 45, hjust = 1)),
                           ggplot(hd_trans, aes(x = Oldpeak, fill = Target))+geom_bar(position = "fill")+
                             theme(axis.text.x = element_text(angle = 45, hjust = 1)))                           


#Multivariate Distribution

##Age, Chest pain and target
bar_graph3 <- ggplot(hd_trans, aes(Age,fill = Target)) + 
  geom_histogram(bins=5, position = 'stack', color="black") +
  scale_x_continuous(trans = "log2") + facet_grid(.~CP)
bar_graph3

## Age, RestECG and Target
bar_graphs4 <- ggplot(hd_trans, aes(Age,fill = Target)) + 
  geom_histogram(bins=5, position = 'stack', color="black") +
  scale_x_continuous(trans = "log2") + facet_grid(.~RestECG)
bar_graphs4

## Sex and chest pain variattions with blood pressure comparisons and chorestrol levels
bp_box <- ggplot(hd_trans, aes(x=Sex,y=Trestbps))+
  geom_boxplot(fill = "pink")+facet_grid(~CP)+geom_smooth()+theme_classic()+
  labs(title = "Comparison of Blood pressure across pain type",x ="Sex",y ="Blood Pressure")
bp_box

chol_box <- ggplot(hd_trans, aes(x=Sex, y=Chol))+
  geom_boxplot(fill = "turquoise")+facet_grid(~CP)+geom_smooth()+theme_classic()+
  labs(title = "Comparison of Cholestoral across pain type ", x = "Sex", y = "Chol")
chol_box
#grid.arrange(bp_box, chol_box, ncol=1, nrow = 2)

#Modelling
# Modelling Data Pre-Processing
#str(hd1)
drops2 <- c("Exang","Thalach", "Age", "Oldpeak")
hd2 <- hd1[ , !(names(hd1) %in% drops2)]
hd2 <- na.omit(hd2)
#str(hd2)
hd2$Target <- as.factor(hd2$Target)
#str(hd2)

## Summary of modelling predictor dataset
summarizeColumns(hd2) %>% knitr::kable( caption = 'Feature Summary before Data Modelling')

# Predictors as a matrix
x <- data.frame(hd2[,1:6])
x = as.matrix(as.data.frame(lapply(x, as.numeric)))
#str(x)

###scaling x
x_centered <- sweep(x, 2, colMeans(x))
x_scaled <- sweep(x_centered, 2, colSds(x), FUN = "/")
sd(x_scaled[,1])

#mean of first column
median(x_scaled[,1])

# Principle Component Analysis (PCA)
#PCA: proportion of variance

pca <- prcomp(x_scaled)
summary(pca)

#pc plotting                    
data.frame(pca$x[,1:2], type = hd2$Target) %>%
  ggplot(aes(PC1, PC2, color = type)) +
  geom_point()

#boxplot
data.frame(type = hd2$Target, pca$x[,1:6]) %>%
  gather(key = "PC", value = "value", -type) %>%
  ggplot(aes(PC, value, fill = type)) +
  geom_boxplot()

# compute the proportion of variance explained
pca <- pca$sdev^2
pca_prop_var_explained <- pca / sum(pca)
pca_cummulative <- cumsum(pca_prop_var_explained) # Cummulative percent explained
tab_pca_prop_var_explained <- tibble(comp = seq(1:ncol(hd2[-7])),
                                     pca_prop_var_explained,
                                     pca_cummulative)
#tab_hd2_prop_var_explained
ggplot(tab_pca_prop_var_explained,
       aes(x = comp, y = pca_cummulative)) +
  geom_point() +
  geom_abline(intercept = 0.95,
              color = 'blue',
              slope = 0)


# Data partitioning
## Ditribution of target variable 
bar_target <- ggplot(hd, aes(x = Target))+geom_bar(fill = "cornflowerblue") + 
  geom_text(stat='count', aes(label=..count..), vjust=-1)
bar_target  

#Split into training and test sets
set.seed(1, sample.kind = "Rounding")

test_index <- createDataPartition(hd2$Target, times = 1, p = 0.2, list = FALSE)
test_x <- x_scaled[test_index,]
test_y <- hd2$Target[test_index]
train_x <- x_scaled[-test_index,]
train_y <- hd2$Target[-test_index]

# portion that is "Y" can be calculated
mean(train_y == "Y")
mean(test_y == "Y")

#1 Kmean clustering
set.seed(3, sample.kind = "Rounding") # if using R 3.6 or later
predict_kmeans <- function(x, k) {
  centers <- k$centers # extract cluster centers
  # calculate distance to cluster centers
  distances <- sapply(1:nrow(x), function(i){
    apply(centers, 1, function(y)
      dist(rbind(x[i,], y)))
  })
  max.col(-t(distances)) # select cluster with min distance to center
}

k <- kmeans(train_x, centers = 2)
#Kmean overall accuracy
kmeans_preds <- ifelse(predict_kmeans(test_x, k) == 1, "Y", "N")
mean(kmeans_preds == test_y) # overall accuracy

#2 Logistic regression model accuracy

train_glm <- train(train_x, train_y, method = "glm")
glm_preds <- predict(train_glm, test_x)
mean(glm_preds == test_y)

#3 LDA model
#library(caret)
train_lda <- train(train_x, train_y,
                   method = "lda")
lda_preds <- predict(train_lda, test_x)
mean(lda_preds == test_y)

#4. QDA model 
train_qda <- train(train_x, train_y,
                   method = "qda")
qda_preds <- predict(train_qda, test_x)
mean(qda_preds == test_y)

#5 Loess model
train_loess <- train(train_x, train_y,
                     method = "gamLoess")
loess_preds <- predict(train_loess, test_x)
mean(loess_preds == test_y)

#6 Knn
set.seed(2, sample.kind = "Rounding")
# value of can be determined
tuning <- data.frame(k = seq(3, 21, 2))
train_knn <- train(train_x, train_y,
                   method = "knn",
                   tuneGrid = tuning)
train_knn$bestTune

#knn accuracy
knn_preds <- predict(train_knn, test_x)
mean(knn_preds == test_y)

#7 Random Forest model
#What value of mtry gives the highest accuracy
#tuning <- data.frame(mtry = c(3, 5, 7, 9)) # can expand to seq(3, 21,2)
#train_rf <- train(train_x, train_y,
                  #method = "rf",
                  #tuneGrid = tuning,
                  #importance = TRUE)
#train_rf$bestTune

#rf accuracy
#save(train_rf, file = "train_rf.RData")
load("train_rf.RData")

rf_preds <- predict(train_rf, test_x)
mean(rf_preds == test_y)

# feature importance
#plot(varImp(train_rf), main="Top variables - Random Forest")
#varImp(train_rf)

#8 Neural Network with PCA Model
#train_nnet_pca <- train(train_x, train_y,
                        #method="nnet",
                        #preProcess=c('center', 'scale', 'pca'),
                        #tuneLength=10,
                        #trace=FALSE)

# accuracy
#save(train_nnet_pca, file = "train_nnet_pca.RData")
load("train_nnet_pca.RData")

nnet_pca_preds <- predict(train_nnet_pca, test_x)
mean(nnet_pca_preds == test_y)

#9 MASS-earth
set.seed(4, sample.kind = "Rounding")
train_earth <- train(train_x, train_y,
                     method="earth",
                     tuneLength=10,
                     trace=FALSE)

# accuracy
save(train_earth, file = "train_earth.RData")
#load("train_earth.RData")

earth_preds <- predict(train_earth, test_x)
mean(earth_preds == test_y)


#9 Neural Network with LDA Model
#train_nnet_lda <- train(train_x, train_y,
                        #method="nnet",
                        #preProcess=c('center', 'scale'),
                       # tuneLength=10,
                        #trace=FALSE)
# accuracy
#save(train_nnet_lda, file = "train_nnet_lda.RData")
#load("train_nnet_lda.RData")
#nnet_lda_preds <- predict(train_nnet_lda, test_x)
#mean(nnet_lda_preds == test_y)

#10. SVM Radial Model
# Creation of SVM Model
#train_svm_rd <- train(train_x, train_y,
                      #method="svmRadial",
                      #tuneLength=15)

# accuracy
#save(train_svm_rd, file = "train_svm_rd.RData")
load("train_svm_rd.RData")

svm_rd_preds <- predict(train_svm_rd, test_x)
mean(svm_rd_preds == test_y)

# feature importance
#plot(varImp(train_svm_rd), main="Top variables - SVM - radial")
#varImp(train_svm_rd)

#11 Adaboost model
set.seed(4, sample.kind = "Rounding")
train_adaboost <- train(train_x, train_y,
                        method="adaboost",
                        tuneLength=5)
# accuracy
save(train_adaboost, file = "train_adaboost.RData")
#load("train_svm_rd.RData")

adaboost_preds <- predict(train_adaboost, test_x)
mean(adaboost_preds == test_y)

#12 Decision tree model
train_dt <- train(train_x, train_y,
                  method="rpart")

# accuracy
dt_preds <- predict(train_dt, test_x)
mean(dt_preds == test_y)

# feature importance
#plot(varImp(train_dt), main="Top variables - Decision Tree")
#varImp(train_dt)

#13 XGBoost Dart model
# Creation of xgboost
#train_xgb_dart <- train(train_x, train_y,
                        #method="xgbDART",
                        #tuneLength=5)
# accuracy
#save(train_xgb_dart, file = "train_xgb_dart.RData")
load("train_xgb_dart.RData")

xgb_dart_preds <- predict(train_xgb_dart, test_x)
mean(xgb_dart_preds == test_y)

#varimp_xgb <- varImp(train_xgb_dart)
#plot(varimp_xgb, main="Variable Importance with XGBoost Dart")

#14 caret ensemble
algorithmList <- c('glm','lda','qda','gamLoess','knn','rf',
                   'nnet','earth','svmRadial','adaboost', 'rpart', 'xgbDART')
set.seed(6, sample.kind = "Rounding")
train_ensemble <- caretList(train_x, train_y, methodList=algorithmList)

# accuracy

save(train_ensemble, file = "train_ensemble.RData")
#load("train_ensemble.RData")

ensemble_preds <- predict(train_ensemble, test_x)
mean(ensemble_preds == test_y)

#varimp_ensemble <- varImp(train_ensemble)
#plot(varimp_ensemble, main="Variable Importance with Ensemble")

#Results
##Parameters of importance plot
par_imp <- grid.arrange(plot(varImp(train_rf), main="Top variables - Random Forest"),
                        plot(varImp(train_svm_rd), main="Top variables - SVM - Radial"),
                        plot(varImp(train_dt), main="Top variables - Decision Tree"),
                        plot(varImp(train_xgb_dart), main="Top variables - XGBoost"))


#Model with highest accuracy

models <- c("K means", "Logistic regression", "LDA", "QDA", "Loess",
            "K Nearest Neighbors", "Random Forest","Neural Network PCA",
            "MARS","Support Vector Machine- Radial",
            "Adaboost", "Decision Tree", "Extreme Gradient Boosting - Dart",
            "Ensemble")
accuracy <- c(mean(kmeans_preds == test_y),
              mean(glm_preds == test_y),
              mean(lda_preds == test_y),
              mean(qda_preds == test_y),
              mean(loess_preds == test_y),
              mean(knn_preds == test_y),
              mean(rf_preds == test_y),
              mean(nnet_pca_preds == test_y),
              mean(earth_preds == test_y),
              mean(svm_rd_preds == test_y),
              mean(adaboost_preds == test_y),
              mean(dt_preds == test_y),
              mean(xgb_dart_preds == test_y),
              mean(ensemble_preds == test_y))
Results <- data.frame(Model = models, Accuracy = accuracy)
#Results

#Results in table

Results %>% knitr::kable( caption = 'Model Accuracy') 

#Graphical representation of key findings
#ordering
ggplot(Results, aes(x=reorder(Model, Accuracy), Accuracy)) +
  geom_bar(stat="identity", fill = "cornflowerblue")+
  geom_text(label = round(Results$Accuracy, 3)) +
  theme_economist_white()+
  labs(title="Results by Overall Accuracy",
       x="Model",
       y="Overall Acurracy")+
  coord_flip()


#Caret mode names
#modelnames <- paste(names(getModelInfo()), collapse=',  ')
#modelnames

#xgboost overall accuracy
xgb_dart_preds <- predict(train_xgb_dart, test_x)
r13 <- mean(xgb_dart_preds == test_y)
r13

xgb_dart_results <- tibble(method = "Extreme Gradient Boosting model", OverallAccuracy = r13)
xgb_dart_results %>% knitr::kable()


# ensemble overall accuracy
ensemble_preds <- predict(train_ensemble, test_x)
r14 <- mean(ensemble_preds == test_y)
r14

ensemble_results <- tibble(method = "Ensemble model", OverallAccuracy = r14)
ensemble_results %>% knitr::kable()

