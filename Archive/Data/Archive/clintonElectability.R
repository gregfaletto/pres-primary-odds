# source(file = "clintonElectability.R")

setwd("/Users/gfaletto/Documents/R/Presidential Odds")




################ Collecting Data  ################





# r.page <- readLines("https://electionbettingodds.com/")

setwd("/Users/gfaletto/Documents/R/Presidential Odds/Data")

load(file="RawHTML__2016-04-16_103359_.R")

setwd("/Users/gfaletto/Documents/R/Presidential Odds")

# save(r.page, file="r.page.R")
# head(r.page, n=10)
# write.table(r.page, "r.page.txt", sep = "\t")


################ Getting All Relevant Data In A Vector  ################


################ Getting Clinton Nomination Probability  ################

nomination.odds <- r.page[57:58]

# nomination.odds.temp <- r.page[57:58]
# nomination.odds <- paste(nomination.odds.temp[1], nomination.odds.temp[2])


##### Determining what number is #####

if (grepl("E0ECF8", nomination.odds[1])) {
  party <- "Democrat"
  probability.type <- "Party Nomination"
} else if (grepl("F8E0E0", nomination.odds[1])) {
  party <- "Republican"
  probability.type <- "Party Nomination"
} else if (grepl("FFFFFF", nomination.odds[1])) {
  probability.type <- "Elected President"
} else {
  print("ERROR: NO PROBABILITY TYPE DETECTED")
}


new.line.1 <- nomination.odds

new.line.2 <- gsub(pattern = ":7%", replacement = "a", x = new.line.1, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.1 <- gsub(pattern = "#E0ECF8", replacement = "a", x = new.line.2, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.2 <- gsub(pattern = "100", replacement = "a", x = new.line.2.1, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.3 <- gsub(pattern = "55pt", replacement = "a", x = new.line.2.2, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.4 <- gsub(pattern = "-10px", replacement = "a", x = new.line.2.3, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.5 <- gsub(pattern = "20pt", replacement = "a", x = new.line.2.4, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.6 <- gsub(pattern = "width=\"20\" height=\"20\">", replacement = "a", x = new.line.2.5, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.7 <- gsub(pattern = "12.5pt", replacement = "a", x = new.line.2.6, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)


##### Getting string for name of candidate (nomination probability)

candidate.name.1 <- substring(new.line.2.7[1], 77)

candidate.name <- sub(".png\" width=\"a\" height=\"140\"></td>\t\t", "", candidate.name.1)

candidate.name <- sub(".jpg\" width=\"a\" height=\"140\"></td>\t\t", "", candidate.name)





##### Getting number for Clinton nomination probability

new.line.3 <- gsub(pattern = "([\t =\\ <\\ >\\ \" /td - : ; , a-z])", replacement = "", x = new.line.2.7[2], ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

# new.line.3.1 <- substring(new.line.3, 3, 6)


if (probability.type == "Party Nomination") {
  nomination.probability <- as.numeric(substring(new.line.3, 3, 6))/100
} else if (probability.type == "Elected President") {
  elected.probability <- as.numeric(substring(new.line.3, 3, 6))/100
} else {
  print("ERROR: PROBABILITY TYPE NOT DETECTED")
}


# new.line.3.2 <- substring(new.line.1[2], 3, 6)


##### Data available now:

# Name of candidate is stored in "candidate.name"

# If this is a party nomination probability, Party is stored in string "party"

# Whether this is the probability of securing a party nomination or presidency is 
# stored in "probability.type"

# If this is a party nomination probability, the probability is stored in 
# "nomination.probability". 

# If this is the probability of being elected president, the probability is stored in 
# "elected.probability" 




################ Getting Clinton Election Probability  ################

##### Getting strings for election probability, removing all other numbers from string


election.odds <- r.page[75:76]

new.line.1b <- election.odds

new.line.2b <- gsub(pattern = ":7%", replacement = "a", x = new.line.1b, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.1b <- gsub(pattern = "#FFFFFF", replacement = "a", x = new.line.2b, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.2b <- gsub(pattern = "100", replacement = "a", x = new.line.2.1b, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.3b <- gsub(pattern = "55pt", replacement = "a", x = new.line.2.2b, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.4b <- gsub(pattern = "-10px", replacement = "a", x = new.line.2.3b, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.5b <- gsub(pattern = "20pt", replacement = "a", x = new.line.2.4b, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.6b <- gsub(pattern = "width=\"20\" height=\"20\">", replacement = "a", x = new.line.2.5b, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.7b <- gsub(pattern = "12.5pt", replacement = "a", x = new.line.2.6b, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)



##### Getting string for name of candidate

elected.candidate.name.1 <- substring(new.line.2.7b[1], 77)

elected.candidate.name <- sub(".jpg\" width=\"a\" height=\"140\"></td>\t\t", "", elected.candidate.name.1)

elected.candidate.name <- sub(".png\" width=\"a\" height=\"140\"></td>\t\t", "", elected.candidate.name)



##### Getting probability of being elected as a string

new.line.3b <- gsub(pattern = "([\t =\\ <\\ >\\ \" /td - : ; , a-z])", replacement = "", x = new.line.2.7b[2], ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.3.1b <- substring(new.line.3b, 3, 6)

elected.probability <- as.numeric(substring(new.line.3b, 3, 6))/100









############### Storing data in a dataframe ######################



# clintonLong.df <- data.frame(matrix(rep(NA,6), ncol = 6))

# names(clintonLong.df) <- c("string.date", "numeric.date", "P(Nominated)", "P(Elected)", "Implied P(Elected|Nominated)")

# clintonLong.df[,1] <- Sys.time()

# clintonLong.df[,2] <- as.numeric(Sys.time())

# clintonLong.df[,3] <- candidate.name

# clintonLong.df[,4] <- as.numeric(new.line.3.1)/100

# clintonLong.df[,5] <- as.numeric(new.line.3.1b)/100

# clintonLong.df[,6] <- clintonLong.df[,4]/clintonLong.df[,3]



time <- Sys.time()


a <- time

b <- as.numeric(time)

c <- candidate.name

d <- nomination.probability     # probability of securing party's nomination

e <- elected.probability   # probability of securing presidency

f <- elected.probability/nomination.probability  # implied P(elected|nominated)


clintonLong.df <- data.frame(a, b, c, d, e, f)

names(clintonLong.df) <- c("string.date", "numeric.date", "Candidate Name", "P(Nominated)", "P(Elected)", "Implied P(Elected|Nominated)")



file.name <- paste("RawHTML ", time)
file.name <- paste(file.name, ".R")

file.name <- gsub(pattern = ":", replacement = "", x = file.name, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

file.name <- gsub(pattern = " ", replacement = "_", x = file.name, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)


setwd("/Users/gfaletto/Documents/R/Presidential Odds/Data")

save(r.page, file=file.name)

setwd("/Users/gfaletto/Documents/R/Presidential Odds")



clinton.file.name <- paste("Clinton ", time)
clinton.file.name <- paste(clinton.file.name, ".R")

clinton.file.name <- gsub(pattern = ":", replacement = "", x = clinton.file.name, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

clinton.file.name <- gsub(pattern = " ", replacement = "_", x = clinton.file.name, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

setwd("/Users/gfaletto/Documents/R/Presidential Odds/Data")

save(clintonLong.df, file=clinton.file.name)


setwd("/Users/gfaletto/Documents/R/Presidential Odds")

print(clintonLong.df)