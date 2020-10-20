load'jd'
jdadminx'corona'
CSVFOLDER =:'/development/j/coronavirus'

NB. build db
jd'csvprobe /replace daily.csv'
jd'csvcdefs /replace /h 1 daily.csv'
jd'csvscan daily.csv'
jd'csvrd daily.csv states'

NB. jd'reads "date","totalTestResults" from states where "state"="TX"'
NB. plot week_mean succ_diff , > (< 1 1) { jd'reads "date","positive" from states where "state"="FL" order by date'


jd'createtable positives date edate,state byte 2,cases int'
jd'createtable tested date edate,state byte 2, tested int'

cases_vect =: jd'reads "date","state","positive" from states'
tested_vect =: jd'reads "date","state","totalTestResults" from states'

jd'insert positives';'date';(,>(< 1 0) { cases_vect);'state';(>(< 1 1) { cases_vect);'cases';(,>(< 1 2) { cases_vect)
jd'insert tested';'date';(,>(< 1 0) { tested_vect);'state';(>(< 1 1) { tested_vect);'tested';(,>(< 1 2) { tested_vect)

jd'ref tested date state positives date state'

NB. jd'reads date,state,tested,positives.cases from tested,tested.positives where positives.cases > _9223372036854775808 and tested > _9223372036854775808'
