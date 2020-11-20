load'common.ijs'
load'state-population.ijs'
load'plot'
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

deaths =: monad define
    jd'reads date,death from states where state="',y,'" and death > _9223372036854775808 order by date'
)

cases =: monad define
    jd'reads date,positive from states where state="',y,'" and positive > _9223372036854775808 order by date'
)

hospitalized =: monad define
    jd'reads date,hospitalizedCurrently from states where state="',y,'" and hospitalizedCurrently > _9223372036854775808 order by date'
)

smoothed_cases =: monad : 'week_mean succ_diff ,> (< 1 1) { cases y'
smoothed_deaths =: monad : 'week_mean succ_diff ,> (< 1 1) { deaths y'
hospitalized_plot =: monad : ',> (< 1 1) { hospitalized y'
deaths_plot =: monad : ',> (< 1 1) { deaths y'

NB. jd'csvrd nst-est2019-alldata.csv statePopulation'
NB. jd'reads NAME,POPESTIMATE2019 from statePopulation'

NB. jd'reads state,positiveIncrease from states where date="2020-10-22"'
NB. jd'reads date,state,tested,positives.cases from tested,tested-positives where positives.cases > _9223372036854775808 and tested > _9223372036854775808 and state="ND" order by date'
