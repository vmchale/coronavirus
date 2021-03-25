load'jd'
jdadminx'corona'
CSVFOLDER =:'~/dev/j/coronavirus'

NB. build db
jd'csvrd cdc.csv states'
jd'csvrd test.csv tests'
jd'csvrd hosp.csv hosp'

load'common.ijs'

read_vector_col =: dyad define
    week_mean , > (<1 1) { jd'reads submission_date,',x,' from states where state="',y,'" order by submission_date'
)

hospitalized_plot =: monad define
    , > (<1 1) { jd'reads date,total_adult_patients_hospitalized_confirmed_and_suspected_covid from hosp where state="',y,'" and total_adult_patients_hospitalized_confirmed_and_suspected_covid > _1 order by date'
)

smoothed_cases =: 'new_case' & read_vector_col
smoothed_deaths =: 'new_death' & read_vector_col
deaths_plot =: 'tot_death' & read_vector_col

load'state-population.ijs'
