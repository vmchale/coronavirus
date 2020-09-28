load'jd'
jdadminx'corona'
CSVFOLDER =:'/home/vanessa/programming/j/coronavirus'

NB. build db
jd'csvprobe /replace daily.csv'
jd'csvcdefs /replace /h 1 daily.csv'
jd'csvscan daily.csv'
jd'csvrd daily.csv states'

NB. jd'reads "date","totalTestResults" from states where "state"="TX"'
