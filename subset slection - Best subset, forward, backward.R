####Best Subset Selection
###Rsq, adj R, RSS
library(ISLR)
fix(Hitters )
names(Hitters)
dim(Hitters)
sum(is.na(Hitters$Salary))
Hitters =na.omit(Hitters)
dim(Hitters )
sum(is.na(Hitters))

install.packages("leaps")



library(leaps)
regfit.full=regsubsets (Salary~.,Hitters)
summary(regfit.full)
regfit.full=regsubsets (Salary???.,data=Hitters ,nvmax=19)
reg.summary =summary (regfit.full)
names(reg.summary)
reg.summary$rsq

par(mfrow=c(2,2))
plot(reg.summary$rss ,xlab="Number of Variables ",ylab="RSS",
       type="l")
plot(reg.summary$adjr2 ,xlab="Number of Variables ",
       ylab="Adjusted RSS",type="l")
which.max(reg.summary$adjr2)
points (11,reg.summary$adjr2[11], col="red",cex=2,pch =20)



#Cp, BIC

plot(reg.summary$cp ,xlab="Number of Variables ",ylab="Cp",
     type='l')
which.min(reg.summary$cp )

points (10,reg.summary$cp [10], col ="red",cex=2,pch =20)
which.min(reg.summary$bic )
plot(reg.summary$bic ,xlab="Number of Variables ",ylab="BIC",
       type='l')
points (6,reg.summary$bic [6],col="red",cex=2,pch =20)





plot(regfit.full ,scale="r2")
plot(regfit.full ,scale="adjr2")
 plot(regfit.full ,scale="Cp")
 plot(regfit.full ,scale="bic")

 coef(regfit.full ,6) 

 
 
 
 regfit.fwd=regsubsets (Salary~.,data=Hitters , nvmax=19,
                          method ="forward")
 summary (regfit.fwd)
regfit.bwd=regsubsets (Salary~.,data=Hitters , nvmax=19,
                          method ="backward")
summary (regfit.bwd) 
coef(regfit.full ,7)
coef(regfit.fwd ,7)
coef(regfit.bwd ,7)

set.seed(1)
train=sample(c(TRUE ,FALSE), nrow(Hitters ),rep=TRUE)
test=(!train)
regfit.best=regsubsets (Salary~.,data=Hitters[train ,],
                        nvmax=19)
test.mat=model.matrix(Salary~.,data=Hitters [test ,])

val.errors =rep(NA ,19)
for(i in 1:19){
   coefi=coef(regfit.best ,id=i)
  pred=test.mat[,names(coefi)]%*%coefi
   val.errors[i]=mean(( Hitters$Salary[test]-pred)^2)
}
