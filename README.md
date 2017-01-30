# pres-primary-odds

## Summary and Background

This project was a way of estimating the opinions of betting markets on the viability of candidates in the 2016 US Presidential Election primaries. Specifically, the code calculated the estimated probability of each candidate winning the presidential election conditional on them securing their party's nomination. The code scraped data from https://electionbettingodds.com/, which, at the time, contained probabilities that each candidate would win their party's nomination, and also the presidency. 

The probabilities from https://electionbettingodds.com/ were derived from the odds on [Betfair](http://betfair.com/), an online gambling website that allows users to bet real money on which candidate would secure their party's nomination, as well as which candidate would eventually win the presidency. As participants bet their money, the odds in the marketplace shifted to reflect the perceived probability of each candidate winning, based on the collective attitudes of all the participants in the marketplace.

For example, on a given day, the odds might have suggested that Hillary Clinton was a 3 to 1 favorite to win the Democratic party's nomination. That means that the betting behavior of everyone in the market up until that moment suggested that Hillary Clinton was about 3 times more likely to secure the Democratic party's nomination than Bernie Sanders. https://electionbettingodds.com/ would take these numbers and calculate that Hillary Clinton therefore has a 75% chance of winning the Democratic party's nomination (again, in the collective opinion of market participants on Betfair). In this way, probabilities for all of the candidates were calculated and displayed on https://electionbettingodds.com/.

This way of estimating the probabilities of each candidate winning has several strengths. Market participants will be reluctant to participate if they are not confident in their opinion, since they are putting real money at risk. Participants can participate in proportion to their confidence in their opinion by betting more money--and therefore may influence the odds line in proportion to their confidence in their opionn. Participants are free to use all publicly available knowledge to make their betting decision, so in theory these odds take into account the sum of all publicly available data, in proportion to its importance--polls, economic indicators, debate performances, news stories, etc.

## Functionality

My code scraped the entirety of https://electionbettingodds.com/ at various times, extracted the probabilities associated with each candidate, arranged this table into a dataframe, and updated an ongoing dataframe filled with data from each candidate over time. It then used the conditional probability formula to calculate the probability of each candidate winning the presidency conditional on them securing their party's nomination:

**<p align="center">P(Elected President|Become Nominee) = P(Elected President)/P(Become Nominee)</p>**

This probability may be one useful way to quantify a candidate's "viability"--their strength as a potential general election candidate.

The code then created several visualizations of the data. First the code created a simple scatterplot of each candidate's current probability of winning conditional on securing their party's nomination. Then it created a line plot of how each candidate's perceived viability changed over time. Finally, it produced a simple line plot of each candidate's overall probability of being elected President over time.

## Files

Here are descriptions of each of the R scripts in this repository:

* **candidateElectability.R:** This is the core code that scraped https://electionbettingodds.com/, collated the data, created and displayed visualizations, and updated the ongoing data files. WARNING: Because www.electionbettingodds.com has changed since the presidential primary season of 2016, this code no longer functions the way it did then. When I was writing this code, I saved a full page of raw data as it had been scraped from the website for the purpose of testing my code as I went. However, the formatting of the website changed over time as candidates dropped out etc., and I had to tweak my code accordingly. This version of code does not work with the raw test data I had saved when I was originally writing the code. Since the presidential primaries are over now, I missed my chance to save a version of the raw data that works with this version of the code.

* **displayData.R:** This code simply creates and displays visualizations of the currently available data. (This code still functions the way it originally did, provided the data files are in the same directory.)

* **listToDf.R:** A simple bit of code I created to make a one-time change of data I had saved as a list into a dataframe, because I realized dataframes would be more appropriate for my project.

* **overwriteTestData.R:** When I was writing candidateElectability.R, sometimes I would do a test run of the data to make sure the code was working the way I wanted, but I didn't want to permanently write the data I had scraped into my ongoing data file. This would have resulted in a lot of redundant data, since I was often testing new code many times in a short period of time. In these situations, I would run overwriteTestData.R after each run of the code in order to delete the last entry in my ongoing data files.
