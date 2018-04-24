# ----------------------------------------
# ranking some cameras from euro.com.pl
# the separation threshold
library("MCDA")
epsilon <-0.01
# the performance table
performanceTable <- rbind(
  c(24.3,25600,2499),
  c(16.3,25600,1739),
  c(10.2,51200,10299),
  c(24.3,25600,1999),
  c(16,25600,2499),
  c(24.3,25600,4999),
  c(16,25600,3849),
  c(16,25600,2449),
  c(24.2,51200,4399),
  c(16.84,25600,1699),
  c(16,25600,2499),
  c(24.3,25600,3495)
)
rownames(performanceTable) <- c(
  "Sony Alpha a6000",
  "Fujifilm X-A10", 
  "Panasonic DC-GH5S",
  "Sony Aplha a5100",
  "Panasonic Lumix DMC-G7",
  "Sony Alpha a7 II",
  "Panasonic Lumix DMC G80",
  "Panasonic Lumix DMC-GX80",
  "Sony Alpha a6300",
  "Panasonic Lumix DMC GX800K",
  "Panasonic Lumix DMC-G7",
  "Sony Aplpha a7K")
colnames(performanceTable) <- c(
  "Rozdzielczość",
  "Zakres czułości",
  "Cena")
# ranks of the alternatives
alternativesRanks <- c(1,2,3,4,5,6,7,8,9,10,11,12)
names(alternativesRanks) <- row.names(performanceTable)
# criteria to minimize or maximize
criteriaMinMax <- c("max","max","min")
names(criteriaMinMax) <- colnames(performanceTable)
x<-additiveValueFunctionElicitation(performanceTable,
                                    criteriaMinMax, epsilon,
                                    alternativesRanks = alternativesRanks)


criteriaNumberOfBreakPoints <- c(3,4,4)
names(criteriaNumberOfBreakPoints) <- colnames(performanceTable)
x<-UTA(performanceTable, criteriaMinMax,
       criteriaNumberOfBreakPoints, epsilon,
       alternativesRanks = alternativesRanks)

# plot the value functions obtained
plotPiecewiseLinearValueFunctions(x$valueFunctions)
# apply the value functions on the original performance table
transformedPerformanceTable <- applyPiecewiseLinearValueFunctionsOnPerformanceTable(
  x$valueFunctions,
  performanceTable)
# calculate the overall score of each alternative
weightedSum(transformedPerformanceTable,c(1,1,1))

print(x)

