library(tidyverse)
library(gdata)
library(corrplot)

# import the data
data <- read.csv('BankCustomerDetails.csv')
View(data)
dim(data)

# factorise the categorical variables
names <- c(2:10,15,21)
data[,names] <- lapply(data[,names],factor)

dim(data)
summary(data)
summary(data$job)
summary(data$education)
summary(data$month)

# check the correlation matrix of the variables
bank_interval_data <- data[c(1,11:14,16:20)]
View(bank_interval_data)
bankMatrix<-cor(bank_interval_data)
round(bankMatrix,2)

# Visualization of significance levels at 0.05
res1 <- corrplot::cor.mtest(bankMatrix, conf.level = .95)
corrplot::corrplot(bankMatrix, p.mat = res1$p, type="lower", sig.level = .05)





# change unknown to NA
data[data=='unknown'] <- NA

data <- subset(data, select = -c(default, education, housing, loan, marital, duration))

dim(data)
summary(data)

# drop the rows with missing value in 'job' column
data <- na.omit(data)

dim(data)

write.csv(data,"BankDataCleaned_1.csv")
