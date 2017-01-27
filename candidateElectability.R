# source(file="candidateElectability.R")

# WARNING: Because www.electionbettingodds.com has changed since the
# presidential primary season of 2016, this code no longer functions
# the way it did then. When I was writing this code, I saved a full
# page of raw data as it had been scraped from the website for the
# purpose of testing my code as I went. However, the formatting of
# the website changed over time as candidates dropped out etc., and
# I had to tweak my code accordingly. This version of code does not
# work with the raw test data I had saved when I was originally
# writing the code. Since the presidential primaries are over now,
# I missed my chance to save a version of the raw data that works
# with this version of the code =(

time <- Sys.time()

load(file="all.odds.R")    # List of all previous data frames  
                           # is now stored in "all.odds"

################ Collecting Data  ################

r.page <- readLines("https://electionbettingodds.com/")

#### If testing, comment out above line, instead use below line ##

# load(file="test.data.R")

################ Getting All Relevant Data In A Matrix  #########

data <- rbind(r.page[58:59], r.page[67:68], r.page[76:77],
  r.page[88:89], r.page[90:91], r.page[93:94], r.page[98:99],
  r.page[100:101], r.page[103:104], r.page[110:111], r.page[113:114],
  r.page[119:120], r.page[122:123], r.page[131:132], r.page[140:141],
  r.page[149:150])


################ Cleaning Data  ################

##### Determining what kind of probability each row is #####

parties <- vector()
probability.types <- vector()

for (i in 1:nrow(data)) {
  str <- data[i,1]
  if (grepl("E0ECF8", str)) {
    parties[i] <- "Dem"
    probability.types[i] <- "Party Nom"
  } else if (grepl("F8E0E0", str)) {
    parties[i] <- "Repub"
    probability.types[i] <- "Party Nom"
  } else if (grepl("FFFFFF", str)) {
    parties[i] <- ""
    probability.types[i] <- "Elected Pres"
  } else {
    print("ERROR: NO PROBABILITY TYPE DETECTED")
  }
}


################ Cleaning Strings  ################

new.line.1 <- data

new.line.2 <- gsub(pattern=":7%", replacement="a", x=new.line.1,
  ignore.case=TRUE, perl=FALSE, fixed=FALSE, useBytes=FALSE)

new.line.2.1 <- gsub(pattern="#E0ECF8", replacement="a",
  x=new.line.2, ignore.case=TRUE, perl=FALSE, fixed=FALSE,
  useBytes=FALSE)

new.line.2.2 <- gsub(pattern="100", replacement="a",
  x=new.line.2.1, ignore.case=TRUE, perl=FALSE, fixed=FALSE,
  useBytes=FALSE)

new.line.2.3 <- gsub(pattern="55pt", replacement="a", x=new.line.2.2,
  ignore.case=TRUE, perl=FALSE, fixed=FALSE, useBytes=FALSE)

new.line.2.4 <- gsub(pattern="-10px", replacement="a", x=new.line.2.3,
  ignore.case=TRUE, perl=FALSE, fixed=FALSE, useBytes=FALSE)

new.line.2.5 <- gsub(pattern="20pt", replacement="a", x=new.line.2.4,
  ignore.case=TRUE, perl=FALSE, fixed=FALSE, useBytes=FALSE)

new.line.2.6 <- gsub(pattern="width=\"20\" height=\"20\">",
  replacement="a", x=new.line.2.5, ignore.case=TRUE, perl=FALSE,
  fixed=FALSE, useBytes=FALSE)

new.line.2.7 <- gsub(pattern="12.5pt", replacement="a",
  x=new.line.2.6, ignore.case=TRUE, perl=FALSE, fixed=FALSE,
  useBytes=FALSE)

clean.test <- new.line.2.7

################ Getting string for name of candidate (nomination # 
################# probability) #####

candidate.name.1 <- substring(clean.test[, 1], 77)

candidate.name <- sub(".png\" width=\"a\" height=\"140\"></td>\t\t",
  "", candidate.name.1)

candidate.name <- sub(".jpg\" width=\"a\" height=\"140\"></td>\t\t",
  "", candidate.name)

candidate.name <- gsub(pattern="src=\"/", replacement="",
  x=candidate.name, ignore.case=TRUE, perl=FALSE, fixed=FALSE,
  useBytes=FALSE)

candidate.name.final <- candidate.name

#################### Getting number for probabilities ##############

new.line.3 <- gsub(pattern="([\t =\\ <\\ >\\ \" /td - : ; , a-z])",
  replacement="", x=clean.test[, 2], ignore.case=TRUE, perl=FALSE,
  fixed=FALSE, useBytes=FALSE)

new.line.3 <- gsub(pattern="#--", replacement="", x=new.line.3,
  ignore.case=TRUE, perl=FALSE, fixed=FALSE, useBytes=FALSE)

new.line.3 <- gsub(pattern="#800", replacement="", x=new.line.3,
  ignore.case=TRUE, perl=FALSE, fixed=FALSE, useBytes=FALSE)

new.line.3 <- gsub(pattern="--", replacement="", x=new.line.3,
  ignore.case=TRUE, perl=FALSE, fixed=FALSE, useBytes=FALSE)

new.line.3 <- sub("%.*$", "", new.line.3 )


#################### Sorting probabilities into vectors ############

nomination.probabilities <- vector()
elected.probabilities <- vector()

for (i in 1:nrow(data)) {

  str <- probability.types[i]

  if (str == "Party Nom") {
    nomination.probabilities[i] <- as.numeric(new.line.3[i])/100
    elected.probabilities[i] <- -1
  } else if (str == "Elected Pres") {
    elected.probabilities[i] <- as.numeric(new.line.3[i])/100
    nomination.probabilities[i] <- -1
  } else {
    print("ERROR: PROBABILITY TYPE NOT DETECTED")
  }
}


#################### Data available now: ###############

# Names of candidates stored in order in "candidate.name.final"

# If this is a party nomination probability, parties are stored in "parties"; otherwise that space in "parties" is blank.

# Whether this is the probability of securing a party nomination or presidency is 
# stored in "probability.types"

# If this is a party nomination probability, the probability is stored in 
# "nomination.probabilities". Otherwise, -1 is stored in that place

# If this is the probability of being elected president, the probability is stored in 
# "elected.probabilities". Otherwise, -1 is stored in that place.

############### Putting Data Into Data frame #################


candidate.name.elec <- vector()
elected.probabilities.elec <- vector()

candidate.name.nom <- vector()
parties.nom <- vector()
nomination.probabilities.nom <- vector()

for (i in 1:length(probability.types)) {
  str <- probability.types[i]
  if (str == "Elected Pres") {
    candidate.name.elec <- c(candidate.name.elec,
      candidate.name.final[i])
    elected.probabilities.elec <- c(elected.probabilities.elec,
      elected.probabilities[i])
  } else {
    candidate.name.nom <- c(candidate.name.nom,
      candidate.name.final[i])
    parties.nom <- c(parties.nom, parties[i])
    nomination.probabilities.nom <- c(nomination.probabilities.nom,
      nomination.probabilities[i])
  }
}

nominations.df <- data.frame(parties.nom,
  nomination.probabilities.nom)

names(nominations.df) <- c("Party", "P(Nominated)")

row.names(nominations.df) <- candidate.name.nom


elected.df <- data.frame(elected.probabilities.elec)

names(elected.df) <- c("P(Elected)")

row.names(elected.df) <- candidate.name.elec


# print(nominations.df)

# print(elected.df)

probs.df <- merge(nominations.df, elected.df, by="row.names",
  all=TRUE)

electability <- probs.df[,4]/probs.df[,3]

probs.df <- data.frame(probs.df, electability, time)

row.names(probs.df) <- probs.df[,1]

probs.df[,1] <- NULL

probs.df <- probs.df[ order(-probs.df[,3]), ]

# print(probs.df)

########### Sort Data into Pre-determined order ###############
########## (may need to change this if candidates drop out) #######

order <- c("Clinton", "Trump", "Cruz", "Sanders", "Kasich",
  "Biden", "Ryan", "Romney")

probs.df <- probs.df[order, ]
    
#################### Saving Data ####################


all.odds[[length(all.odds)+1]] <- probs.df

save(all.odds, file="all.odds.R")

write.table(all.odds, "all.odds.txt", sep="\t")


########### If testing, run "overwriteTestData.R" after to delete ##
########### last (dummy) item on list) ###################



#################### Plotting Data ####################

library(ggplot2)

image <- ggplot(all.odds[[length(all.odds)]],
  aes(x=rownames(all.odds[[length(all.odds)]]), y=electability)) +
  geom_point() + scale_x_discrete("Candidate") +
  scale_y_continuous("P(Elected|Nominated)", limits=c(0, 1))
print(image)
### ^ plots most recent data, x axis is names, y axis is 
### P(elected|nominated)

## Changing scales of axes (modify code below)

# + scale_y_continuous("P(Elected|Nominated)", limits=c(0, 1))

readline(prompt="Press [enter] to continue")

#################### Plotting Chart Over Time ####################

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

save(all.odds.list, file="all.odds.list.R")

## Print Image

electability.graph <- ggplot(all.odds.list, aes(x=time,
  y=electability, color=Candidate)) + geom_line() +
  scale_y_continuous("P(Elected|Nominated)", limits=c(0, 1))
print(electability.graph)

readline(prompt="Press [enter] to continue")

elected.graph <- ggplot(all.odds.list, aes(x=time, y=P.Elected., 
  color=Candidate)) + geom_line() + scale_y_continuous("P(Elected)", 
limits=c(0, 1))
print(elected.graph)

## + scale_x_continuous("Time")

detach("package:ggplot2", unload=TRUE)


############# Steps for automated code ############

# quit(save="no")
################# Old file-writing code ###########################


# r.file.name <- paste(time, ".R")

# r.file.name <- gsub(pattern=":", replacement="", x=r.file.name,
#   ignore.case=TRUE, perl=FALSE, fixed=FALSE, useBytes=FALSE)

# r.file.name <- gsub(pattern=" ", replacement="_", x=r.file.name,
#   ignore.case=TRUE, perl=FALSE, fixed=FALSE, useBytes=FALSE)

# readable.file.name <- paste(time, ".txt")

# readable.file.name <- gsub(pattern=":", replacement="",
#   x=readable.file.name, ignore.case=TRUE, perl=FALSE, fixed=FALSE,
#   useBytes=FALSE)

# readable.file.name <- gsub(pattern=" ", replacement="_",
#   x=readable.file.name, ignore.case=TRUE, perl=FALSE,
#   fixed=FALSE, useBytes=FALSE)

# save(probs.df, file=r.file.name)

# write.table(probs.df, readable.file.name, sep="\t")