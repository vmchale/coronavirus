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

week_mean =: 7 (+/%#)\]

NB. chicago_smooth =: week_mean , > (< 1 0) { jd'reads cases_total from chicagoCases where not date = "?"'
hospitalized_plot =: , > (<1 1) { jd'reads date,combined_hospital_beds_in_use_covid_19 from chicagoHospitalized where combined_hospital_beds_in_use_covid_19 > _1 order by date'

NB. icu_plot =: , > (<1 1) { jd'reads date,icu_beds_in_use_covid_19 from chicagoHospitalized order by date'

tested =: ,> (< 1 1) { jd'reads date,people_tested_total from chicagoTested where not date = "?" order by date'
positive =: ,> (< 1 1) { jd'reads date,people_positive_total from chicagoTested where not date = "?" order by date'
chicago_smooth =: week_mean positive

NB. higher than reported rate on chicago website b/c those are unique
pp =: positive % tested

NB. https://www.bmj.com/content/bmj/369/bmj.m1808.full.pdf
