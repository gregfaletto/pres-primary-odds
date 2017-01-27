# source(file = "overwriteTestData.R")

all.odds[length(all.odds)] <- NULL

save(all.odds, file = "all.odds.R")

write.table(all.odds, "all.odds.txt", sep = "\t")