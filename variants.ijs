load'jd'
jdadminx'variants'
CSVFOLDER =:'/development/j/coronavirus'

jd'csvprobe /replace variants.csv'
jd'csvcdefs /replace /h 1 variants.csv'
jd'csvscan variants.csv'
jd'csvrd variants.csv variants'

jd'csvrd bc.csv bc'

jd'csvrd us.csv us'

NB. data from covariants.org
jd'csvrd covariants.csv covariants'

jd'csvrd wa.csv wa'

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

fnights_variants_ =: 2 ]\] > (<1 0) { jd'reads Fortnight from covariants'

jd'csvrd cdc.csv states'

cases_in_variants_ =: dyad define
    ,>(<1 0) { jd'reads sum new_case from states where submission_date <="',x,'" and submission_date > "',y,'"'
)

cases_by_fnight =: , cases_in_variants_ / " 2 fnights_variants_

percent_variant_variants_ =: monad define
    100%~ ,>(<1 0) { jd'reads "',y,'" from covariants'
)

abs_cases =: monad define
    |. (}: percent_variant_variants_ y) * cases_by_fnight
)

present_variant =: monad define
    dates =. dates =: }. |. > (<1 0) { jd'reads Fortnight from covariants'
    pres =. ,"0 abs_cases y
    ('Fortnight';y) ,: (dates;pres)
)

NB. plot (|. cases_by_fnight) ,: (abs_cases'B.1.1.7')

NB. percent_table =: ([ %"1 +/) var_tab

NB. area_plot =: |."2 +/\ percent_table
