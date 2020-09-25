states:("DSI  IIII       II                               ";enlist ",")0:`:daily.csv
excess:("DSI  I           ";enlist ",")0:`:excess.csv
excess:`date`state`observed`expected xcol excess
\
`date`excess xcol select date,observed-expected from excess where state=`Texas, date>2020.02.29
