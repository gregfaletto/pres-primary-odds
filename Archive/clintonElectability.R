setwd("/Users/gfaletto/Documents/R/Presidential Odds")
r.page <- readLines("https://electionbettingodds.com/")
# save(r.page, file="r.page.R")
# head(r.page, n=10)
# write.table(r.page, "r.page.txt", sep = "\t")
nomination.odds <- r.page[57:58]

new.line.1 <- nomination.odds

new.line.2 <- gsub(pattern = ":7%", replacement = "a", x = new.line.1, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.1 <- gsub(pattern = "#E0ECF8", replacement = "a", x = new.line.2, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.2 <- gsub(pattern = "100", replacement = "a", x = new.line.2.1, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.3 <- gsub(pattern = "55pt", replacement = "a", x = new.line.2.2, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.4 <- gsub(pattern = "-10px", replacement = "a", x = new.line.2.3, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.5 <- gsub(pattern = "20pt", replacement = "a", x = new.line.2.4, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.6 <- gsub(pattern = "width=\"20\" height=\"20\">", replacement = "a", x = new.line.2.5, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.2.7 <- gsub(pattern = "12.5pt", replacement = "a", x = new.line.2.6, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)



new.line.3 <- gsub(pattern = "([\t =\\ <\\ >\\ \" /td - : ; , a-z])", replacement = "", x = new.line.2.7[2], ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

new.line.3.1 <- substring(new.line.3, 3, 6)


# new.line.3.2 <- substring(new.line.1[2], 3, 6)




clinton.df <- data.frame(matrix(rep(NA,3), ncol = 3))

names(clinton.df) <- c("string.date", "numeric.date", "Nomination Probability")

clinton.df[,1] <- Sys.time()

clinton.df[,2] <- as.numeric(Sys.time())

clinton.df[,3] <- as.numeric(new.line.3.1)

print(clinton.df)