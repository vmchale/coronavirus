load'states-db.ijs'

jd'createtable positives date edate,state byte 2,cases int'
jd'createtable tested date edate,state byte 2, tested int'

cases_vect =: jd'reads "date","state","positive" from states'
tested_vect =: jd'reads "date","state","totalTestResults" from states'

jd'insert positives';'date';(>(< 1 0) { cases_vect);'state';(>(< 1 1) { cases_vect);'cases';(,>(< 1 2) { cases_vect)
jd'insert tested';'date';(>(< 1 0) { tested_vect);'state';(>(< 1 1) { tested_vect);'tested';(,>(< 1 2) { tested_vect)

NB. /left to allow inner joins
jd'ref /left tested date state positives date state'

NB. reorder 'and ...'s?
tested_pp_ =: monad define
     , > (< 1 1) { jd'reads date,tested from tested,tested-positives where positives.cases > _9223372036854775808 and tested > _9223372036854775808 and state="',y,'" order by date'
)

cases_pp_ =: monad define
     , > (< 1 1) { jd'reads date,positives.cases from tested,tested-positives where positives.cases > _9223372036854775808 and tested > _9223372036854775808 and state="',y,'" order by date'
)

pp =: cases_pp_ (% &: succ_diff) tested_pp_
