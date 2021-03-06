load'jd'
jdadminx'variants'
CSVFOLDER =:'~/dev/j/coronavirus'

jd'csvprobe /replace variants.csv'
jd'csvcdefs /replace /h 1 variants.csv'
jd'csvscan variants.csv'
jd'csvrd variants.csv variants'

pos =: monad define
    ,> (<1 1) { jd'reads collection_date,positive from variants where state="',y,'"'
)

sgtf =: monad define
    ,> (<1 1) { jd'reads collection_date,all_SGTF from variants where state="',y,'"'
)
