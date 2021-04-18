load'jd'
jdadminx'corona'
CSVFOLDER =:'~/dev/j/coronavirus'

NB. build db
jd'csvrd cdc.csv states'

NB. jd'csvprobe /replace test.csv'
NB. jd'csvcdefs /replace /h 1 test.csv'
NB. jd'csvscan test.csv'
jd'csvrd test.csv tests'
NB. jd'intx tests state byte'
NB. jd'csvrd hosp.csv hosp'

load'common.ijs'

read_vector_col =: dyad define
    week_mean , > (<1 1) { jd'reads submission_date,',x,' from states where state="',y,'" order by submission_date'
)

NB. hospitalized_plot =: monad define
    NB. , > (<1 1) { jd'reads date,total_adult_patients_hospitalized_confirmed_and_suspected_covid from hosp where state="',y,'" and total_adult_patients_hospitalized_confirmed_and_suspected_covid > _1 order by date'
NB. )

smoothed_cases =: 'new_case' & read_vector_col
smoothed_deaths =: 'new_death' & read_vector_col
deaths_plot =: 'tot_death' & read_vector_col

NB. rename columns so we can do joins on them (limitation of jd)
jd'renamecol states submission_date submissionDate'

jd'ref /left tests state date states state submissionDate'

load'state-population.ijs'

NB. load'states.ijs'
NB. deaths_vect =: (({:@:deaths_plot)@>) state_abbr
NB. pop_vect =: pop_state@> states
NB. |: states,:<"0 deaths_vect%pop_vect
