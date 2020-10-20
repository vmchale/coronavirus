load'jd'
jdadminx'corona'
CSVFOLDER =:'/development/j/coronavirus'

NB. https://www.census.gov/quickfacts/fact/table/chicagocityillinois/POP010210
chi_pop =: 2695598

NB. build dbs
jd'csvprobe /replace chicago-cases.csv'
jd'csvcdefs /replace /h 1 /v 30 chicago-cases.csv'
jd'csvscan chicago-cases.csv'
jd'csvrd chicago-cases.csv chicagoCases'

jd'csvprobe /replace chicago-hospitalized.csv'
jd'csvcdefs /replace /h 1 /v 30 chicago-hospitalized.csv'
jd'csvscan chicago-hospitalized.csv'
jd'csvrd chicago-hospitalized.csv chicagoHospitalized'

jd'csvprobe /replace chicago-tested.csv'
jd'csvcdefs /replace /h 1 /v 30 chicago-tested.csv'
jd'csvscan chicago-tested.csv'
jd'csvrd chicago-tested.csv chicagoTested'
