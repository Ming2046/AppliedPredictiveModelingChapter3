library(AppliedPredictiveModeling)
data("segmentationOriginal")
View(segmentationOriginal)
colnames(segmentationOriginal)
segData <- subset(segmentationOriginal, Case =="Train")
cellID <- segData$Cell
class <- segData$Class
case <- segData$Case
# Remove Cell, Class, and Case columns from segData dataset
segData <- segData[,-(1:3)]

# remove columns that contain "status"

statusColNum <- grep("Status", names(segData))
statusColNum
segData <- segData[,-statusColNum]

# segData datset reduces to 58 variables from 119

#### Transformation

library(e1071)
skewness(segData$AngleCh1)
skewnessValues <- apply(segData,2,skewness)
head(skewnessValues)
library(caret)
library(ggplot2)
Ch1AreaTrans <- BoxCoxTrans(segData$AreaCh1)
Ch1AreaTrans
#original dataset
head(segData$AreaCh1)
#after transformation
predict(Ch1AreaTrans,head(segData$AreaCh1))

pcaObject <- prcomp (segData,center = TRUE, scale. = TRUE)
# in the book, sd is used instead of sdev, sdev and sd procude same results
percentVariance <- pcaObject$sdev^2/sum(pcaObject$sdev^2)*100
percentVariance[1:3]
percentVariance

head(pcaObject$x[,1:5])

head(pcaObject$rotation[,1:3])

trans <- preProcess(segData,method = c("BoxCox","center","scale","pca"))
trans

transfomred <- predict(trans,segData)
head(transfomred[,1:5])

#### flitering

nearZeroVar(segData)

correlations <- cor(segData)
dim(correlations)
correlations [1:4,1:4]
library(corrplot)
corrplot(correlations,order = "hclust")

highCorr <- findCorrelation(correlations,cutoff = 0.75)
length(highCorr)
head(highCorr)

filteredSegData <- segData[,-highCorr]
