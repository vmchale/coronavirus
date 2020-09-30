load'jd'
jdadminx'corona'
CSVFOLDER =:'/home/vanessa/programming/j/coronavirus'

jd'csvprobe /replace excess.csv'
jd'csvcdefs /replace /h 1 excess.csv'
jd'csvscan excess.csv'
jd'csvrd excess.csv excess'

NB. get observed and expected data
NB. jd'reads "Week Ending Date","Observed Number","Average Expected Count" from excess where State="Texas" and "Week Ending Date" >= "2020-02-29"'

decolumnize =: ,@:>@{:
