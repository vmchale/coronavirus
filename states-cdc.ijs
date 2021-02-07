load'jd'
jdadminx'corona'
CSVFOLDER =:'~/dev/j/coronavirus'

NB. build db
jd'csvrd cdc.csv states'
jd'csvrd test.csv tests'


load'common.ijs'

read_vector_col =: dyad define
    week_mean , > (<1 1) { jd'reads submission_date,',x,' from states where state="',y,'" order by submission_date'
)

smoothed_cases =: 'new_case' & read_vector_col
smoothed_deaths =: 'new_death' & read_vector_col
deaths_plot =: 'tot_death' & read_vector_col

load'state-population.ijs'
