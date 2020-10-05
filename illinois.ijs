load'jd'
jdadminx'corona'
CSVFOLDER =:'/home/vanessa/programming/j/coronavirus'

jd'csvprobe /replace illinois.csv'
jd'csvcdefs /replace /h 1 illinois.csv'
jd'csvscan illinois.csv'
jd'csvrd illinois.csv illinois'
