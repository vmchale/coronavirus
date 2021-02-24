load'jd'
jdadminx'vaccines'
CSVFOLDER =:'/development/j/coronavirus'

jd'csvprobe /replace pfizer.csv'
jd'csvcdefs /replace /h 1 /v 30 pfizer.csv'
jd'csvscan pfizer.csv'
jd'csvrd pfizer.csv pfizer'

jd'csvprobe /replace moderna.csv'
jd'csvcdefs /replace /h 1 /v 30 moderna.csv'
jd'csvscan moderna.csv'
jd'csvrd moderna.csv moderna'

moderna_table =: monad define
    jd'reads "Week of Allocations","1st Dose Allocations" from moderna where Jurisdiction="',y,'"'
)

pfizer_table =: monad define
    jd'reads "Week of Allocations","1st Dose Allocations" from pfizer where Jurisdiction="',y,'"'
)
