load'tables/csv'

excess_death_table =: readcsv 'Excess_Deaths_Associated_with_COVID-19.csv'

state_ixes =: monad : 'I. (=& (< y) (1&{" 1) excess_death_table)'

ga_ixes =: state_ixes 'Georgia'
ny_ixes =: state_ixes 'New York'
tx_ixes =: state_ixes 'Texas'
ok_ixes =: state_ixes 'Oklahoma'
la_ixes =: state_ixes 'Louisiana'
il_ixes =: state_ixes 'Illinois'

colize =: dyad : '> makenum each y&{"1 x { excess_death_table'

NB. 'Oberserved Number'
deaths_actual =: colize & 2
deaths_expected =: colize & 5

excess =: deaths_actual - deaths_expected
