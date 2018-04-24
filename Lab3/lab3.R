# run analysis
library(ahp)
ahpFile <- system.file("extdata", "cam2.ahp", package="ahp")
cameraAhp <- Load(ahpFile)
Calculate(cameraAhp)
Visualize(cameraAhp)
Analyze(cameraAhp)
AnalyzeTable(cameraAhp)
AnalyzeTable(cameraAhp, decisionMaker = "Father")
AnalyzeTable(cameraAhp, decisionMaker = "Mother")
AnalyzeTable(cameraAhp, decisionMaker = "Child")


