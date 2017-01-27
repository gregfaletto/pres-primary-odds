# source(file="listToDf.R")

load(file="all.odds.R")

## If necessary, add Names column to dataframe (first column)

temp <- all.odds

for (i in 1:length(temp)) {
	if (names(temp[[i]])[1] != "Candidates") {
		names <- rownames(temp[[i]])
		temp[[i]] <- cbind(names, temp[[i]])
		names(temp[[i]])[1] <- "Candidates"
	}
}

## Change dataframe to list

all.odds.list <- do.call("rbind", temp)
row.names(all.odds.list) <- NULL

save(all.odds.list, file="all.odds.list.R")

## Print Image

image2 <- ggplot(all.odds.list, aes(x=time, y=electability,
	color=Candidates)) + geom_line() +
	scale_y_continuous("P(Elected|Nominated)", limits=c(0, 1))
print(image2)

## + scale_x_continuous("Time")