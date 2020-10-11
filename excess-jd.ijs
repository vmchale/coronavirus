load'jd'
jdadminx'corona'
CSVFOLDER =:'/home/vanessa/programming/j/coronavirus'

NB. jd'csvprobe /replace excess.csv'
NB. jd'csvcdefs /replace /h 1 /v 11 excess.csv'
NB. jd'csvscan excess.csv'
jd'csvrd excess.csv excess'

NB. get observed and expected data
NB. jd'reads "Week Ending Date","Observed Number","Average Expected Count" from excess where State="Texas" and "Week Ending Date" >= "2020-02-29" and Type="Unweighted" and Outcome="All causes"'

decolumnize =: ,@:>@{:
