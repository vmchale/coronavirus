load'jd'
jdadminx'variants'
CSVFOLDER =:'~/dev/j/coronavirus'

jd'csvprobe /replace variants.csv'
jd'csvcdefs /replace /h 1 variants.csv'
jd'csvscan variants.csv'
jd'csvrd variants.csv variants'

jd'csvrd bc.csv bc'

jd'csvrd us.csv us'

pos =: monad define
    ,> (<1 1) { jd'reads collection_date,positive from variants where state="',y,'"'
)

sgtf =: monad define
    ,> (<1 1) { jd'reads collection_date,all_SGTF from variants where state="',y,'"'
)

load'common.ijs'

present =: monad : '(week_mean pos y) ,: (week_mean sgtf y)'

sel_var =: monad define
    2 -~/\ ] ,> (<1 1) { jd'reads Date,"',y,'" from bc order by Date'
)

p1 =: sel_var'P.1'
b117 =: sel_var'B.1.1.7'
b351 =: sel_var'B.1.351'

var_tab =: (2 -~/\ ]) " 1 ,"2> }. {: jd'reads from bc order by Date'
NB. percent_table =: ([ %"1 +/) var_tab

NB. area_plot =: |."2 +/\ percent_table
