states:("DSIIIIIIIIII II";enlist ",")0:`:cdc.csv
excess:("DSI  I       S   ";enlist ",")0:`:excess.csv
excess:`date`state`observed`expected`weighted xcol excess
excess:select date,state,observed,expected from excess where weighted=`Unweighted
\
select date,excess:observed-expected from excess where state=`Texas, date>2020.02.29, date<2020.09.05
