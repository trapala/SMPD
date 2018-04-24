# ranking some cameras from euro.com.pl
# run analysis
library(ahp)
ahpFile <- system.file("extdata", "cam.ahp", package="ahp")
cameraAhp <- Load(ahpFile)
Calculate(cameraAhp)
Visualize(cameraAhp)
Analyze(cameraAhp)
AnalyzeTable(cameraAhp)