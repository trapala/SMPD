library("neuralnet")

#Going to create a neural network to perform prediction
#Type ?neuralnet for more information on the neuralnet library

#Generate training data
#And store them as a dataframe
traininginput <- as.data.frame(matrix(c(24.3,25600,100,
                                        16.3,25600,100,
                                        10.2,51200,160,
                                        24.3,25600,100,
                                        16,25600,200,
                                        24.3,25600,200,
                                        16,25600,200,
                                        16,25600,100,
                                        24.2,51200,200,
                                        16.84,25600,100,
                                        16,25600,100,
                                        24.3,25600,100), nrow=12, ncol=3))
trainingoutput <- c(2499, 1739, 10299, 1999, 2499, 4999, 3849, 2449, 4399, 1699, 2499, 3495, 189, 369, 319, 399, 200, 269, 159, 419)

#Column bind the data into one variable
trainingdata <- cbind(traininginput, trainingoutput)

# Create Vector of ColumnMax and Min Values
maxs <- apply(trainingdata[,], 2, max)
mins <- apply(trainingdata[,], 2, min)

# Use scale() and convert the resulting matrix to a data frame
scaled.trainingdata <- as.data.frame(scale(trainingdata[,], center=mins, scale=maxs-mins))
trainingdata <- scaled.trainingdata

# Check out results
print(head(trainingdata, 10))

colnames(trainingdata) <- c("rozdzielczosc", "maxCzulosc", "minCzulosc", "Cena") 
print(trainingdata)

#Train the neural network
#Going to have C(5, 4, 3) hidden layers
#Threshold is a numeric value specifying the threshold for the partial
#derivatives of the error function as stopping criteria.
net.price <- neuralnet(Cena~rozdzielczosc+maxCzulosc+minCzulosc, trainingdata, hidden=c(5, 4, 3), threshold=0.001)
print(net.price)

#Plot the neural network
plot(net.price)

#Test the neural network on some training data
testdata <- as.data.frame(matrix(c(16,25600,200,
                                   24.3,25600,200,
                                   16,25600,200), nrow=3, ncol=3))
scaled.testdata <- as.data.frame(scale(testdata[,], center=mins[1:3], scale=maxs[1:3]-mins[1:3]))
net.results <- compute(net.price, scaled.testdata) #Run them through the neural network

#Lets see what properties net.price has
ls(net.results)

#Lets see the results
print(net.results$net.result)