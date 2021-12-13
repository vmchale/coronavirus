data <- read.csv("excess.csv")

popTable <- read.csv("nst-est2019-alldata.csv")

library(dplyr)

library(rbenchmark)

benchmark("r" = {
            data$Excess <- data$ObservedNumber - data$AverageExpectedCount
            data$WeekEndingDate <- as.Date(data$WeekEndingDate, format="%Y-%m-%d")

            excessTable <- data |> filter(Type=='Unweighted' & Outcome=='Allcauses' & WeekEndingDate < "2021-11-13" & WeekEndingDate > '2020-03-13') |> group_by(State) |> summarise(Excess = sum(Excess))

            joined <- merge(x = excessTable, y = popTable, by.x = 'State', by.y = 'NAME')

            joined$ExcessPP <- joined$Excess / joined$POPESTIMATE2019

            select(joined, State, ExcessPP) |> arrange(desc(ExcessPP))
          },
          replications=100
          )
