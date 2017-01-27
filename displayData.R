# source(file="candidateElectability.R")

rm(list=ls())

load(file="all.odds.R")    # List of all previous data
                           # frames is now stored in 
                           # "all.odds"


#################### Plotting Data ####################

library(ggplot2)

image <- ggplot(all.odds[[length(all.odds)]],
	aes(x=rownames(all.odds[[length(all.odds)]]),
	y=electability)) + geom_point() +
	scale_x_discrete("Candidate") +
	scale_y_continuous("P(Elected|Nominated)",
		limits=c(0, 1))
print(image)
### ^ plots most recent data, x axis is names, 
# y axis is P(elected|nominated)

## Changing scales of axes (modify code below)

# + scale_y_continuous("P(Elected|Nominated)", limits=c(0, 1))

# readline(prompt="Press [enter] to continue")

#################### Plotting Chart Over Time ##############

## note: code copied from (listToDf.R)

## If necessary, add Names column to dataframe (first column)

temp <- all.odds

for (i in 1:length(temp)) {
  if (names(temp[[i]])[1] != "Candidate") {
    names <- rownames(temp[[i]])
    temp[[i]] <- cbind(names, temp[[i]])
    names(temp[[i]])[1] <- "Candidate"
  }
}

## Change dataframe to list

all.odds.list <- do.call("rbind", temp)
row.names(all.odds.list) <- NULL

# save(all.odds.list, file="all.odds.list.R")

## Print Image

electability.graph <- ggplot(all.odds.list, aes(x=time,
	y=electability, color=Candidate)) + geom_line() +
	scale_y_continuous("P(Elected|Nominated)", limits=c(0, 1))
print(electability.graph)

# readline(prompt="Press [enter] to continue")

elected.graph <- ggplot(all.odds.list, aes(x=time, y=P.Elected., 
  color=Candidate)) + geom_line() +
  scale_y_continuous("P(Elected)", limits=c(0, 1))
print(elected.graph)

## + scale_x_continuous("Time")

detach("package:ggplot2", unload=TRUE)