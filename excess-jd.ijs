load'jd'
jdadminx'corona'
CSVFOLDER =:'~/dev/j/coronavirus'

NB. jd'csvprobe /replace excess.csv'
NB. jd'csvcdefs /replace /h 1 /v 11 excess.csv'
NB. jd'csvscan excess.csv'
jd'csvrd excess.csv excess'

jd'csvrd excess-age.csv excessAge'

NB. jd'reads "Week Ending Date","State Abbreviation","Age Group","Number of Deaths" from excessAge where "State Abbreviation"="NY" and "Week Ending Date" > "2020-01-01"'

NB. get observed and expected data
NB. jd'reads "Week Ending Date","Observed Number","Average Expected Count" from excess where State="Texas" and "Week Ending Date" >= "2020-02-29" and Type="Unweighted" and Outcome="All causes"'
NB.
NB. jd'reads sum "Observed Number", sum "Average Expected Count" from excess where State="Texas" and "Week Ending Date" >= "2020-02-29" and "Week Ending Date" <= "2020-09-26" and Type="Unweighted" and Outcome="All causes"'

NB. jd'reads "date","death" from states where "state"="TX" order by date'
NB. jd'reads "Week Ending Date","Observed Number","Average Expected Count" from excess where State="United States" and "Week Ending Date" >= "2020-02-29" and Type="Predicted (weighted)" and Outcome="All causes"'

decolumnize =: ,@:>@{:
