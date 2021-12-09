excess:`:excess.csv
excessTable:("DSI  I    SS   "; enlist ",") 0: excess
states:(select distinct State from excessTable)[`State]
inspect:{`WeekEndingDate xdesc select WeekEndingDate,State,ObservedNumber-AverageExpectedCount from excessTable where Type=`Unweighted, WeekEndingDate > 2020.03.13, Outcome=`Allcauses, State=x}
/ select sum(ObservedNumber-AverageExpectedCount) from excessTable where Type=`Unweighted, Outcome=`Allcauses, WeekEndingDate > 2020.03.13, State=`Texas, WeekEndingDate < 2021.03.21
/ TODO: Outcome=`Allcauses ??
/ https://code.kx.com/q4m3/6_Functions/#672-each
/ inspect each states
