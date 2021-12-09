excessTable:("DSI  I    SS   "; enlist ",") 0: `:excess.csv
popTable:("    S           I";enlist",") 0:`:pop.csv
popTable:`State xkey `State xcol popTable
/ states:(select distinct State from excessTable)[`State]
inspect:{`WeekEndingDate xdesc select WeekEndingDate,State,ObservedNumber-AverageExpectedCount from excessTable where Type=`Unweighted, WeekEndingDate > 2020.03.13, Outcome=`Allcauses, State=x}
/ `ObservedNumber xdesc select State,ObservedNumber%POPESTIMATE2019 from ((select sum ObservedNumber-AverageExpectedCount by State from excessTable where Type=`Unweighted, Outcome=`Allcauses, WeekEndingDate > 2020.03.13, WeekEndingDate < 2021.11.13) ij popTable)
