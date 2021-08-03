load'jd'
jdadminx'corona'
CSVFOLDER =:'/development/j/coronavirus'

NB. build db
jd'csvrd cdc.csv states'

jd'csvprobe /replace hosp.csv'
jd'csvcdefs /replace /h 1 hosp.csv'
jd'csvscan hosp.csv'
jd'csvrd hosp.csv hosp'

NB. jd'csvprobe /replace test.csv'
NB. jd'csvcdefs /replace /h 1 test.csv'
NB. jd'csvscan test.csv'
jd'csvrd test.csv tests'
NB. jd'intx tests state byte'
NB. jd'csvrd hosp.csv hosp'

load'common.ijs'

NB. rename columns so we can do joins on them (limitation of jd)
jd'renamecol states submission_date submissionDate'

read_vector_col =: dyad define
    week_mean , > (<1 1) { jd'reads submissionDate,',x,' from states where state="',y,'" order by submissionDate'
)

hospitalized_plot =: monad define
    ,> (< 1 1) { jd'reads date,total_adult_patients_hospitalized_confirmed_covid from hosp where state="',y,'" and total_adult_patients_hospitalized_confirmed_covid > 0 order by date'
)

icu_plot =: monad define
    ,> (< 1 1) { jd'reads date,staffed_icu_adult_patients_confirmed_and_suspected_covid from hosp where state="',y,'" and total_adult_patients_hospitalized_confirmed_covid > 0 order by date'
)

smoothed_cases =: 'new_case' & read_vector_col
smoothed_deaths =: 'new_death' & read_vector_col
deaths_plot =: 'tot_death' & read_vector_col

jd'ref /left tests state date states state submissionDate'

NB. jd'reads sum new_results_reported by date,state,states.new_case from tests,tests-states order by date'
new_cases =: monad define
    , > (<1 2) { jd'reads sum new_results_reported by date,state,states.new_case from tests,tests-states where state="',y,'" order by date'
)

new_tests =: monad define
    , > (<1 3) { jd'reads sum new_results_reported by date,state,states.new_case from tests,tests-states where state="',y,'" order by date'
)
NB. _7 {. week_mean (new_cases%new_tests) 'FL'

load'state-population.ijs'

NB. load'states.ijs'
NB. deaths_vect =: (({:@:deaths_plot)@>) state_abbr
NB. pop_vect =: pop_state@> states
NB. |: states,:<"0 deaths_vect%pop_vect
