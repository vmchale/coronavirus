load'jd'
jdadminx'corona'
CSVFOLDER =:'/home/vanessa/programming/j/coronavirus'

NB. build dbs
jd'csvprobe /replace chicago-cases.csv'
jd'csvcdefs /replace /h 1 chicago-cases.csv'
jd'csvscan chicago-cases.csv'
jd'csvrd chicago-cases.csv chicagoCases'

jd'csvprobe /replace chicago-hospitalized.csv'
jd'csvcdefs /replace /h 1 chicago-hospitalized.csv'
jd'csvscan chicago-hospitalized.csv'
jd'csvrd chicago-hospitalized.csv chicagoHospitalized'

jd'csvprobe /replace chicago-tested.csv'
jd'csvcdefs /replace /h 1 chicago-tested.csv'
jd'csvscan chicago-tested.csv'
jd'csvrd chicago-tested.csv chicagoTested'
