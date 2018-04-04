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
