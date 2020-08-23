load'tables/csv'

excess_death_table =: readcsv 'Excess_Deaths_Associated_with_COVID-19.csv'

state_ixes =: monad : 'I. (=& (< y) (1&{" 1) excess_death_table)'

ga_ixes =: state_ixes 'Georgia'

colize =: dyad : '> makenum each y&{"1 x { excess_death_table'

NB. 'Oberserved Number'
deaths_actual =: colize & 2
deaths_expected =: colize & 5
