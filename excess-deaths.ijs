load'tables/csv'

excess_death_table =: readcsv 'Excess_Deaths_Associated_with_COVID-19.csv'

state_ixes =: monad : 'I. (=& (< y) (1&{" 1) excess_death_table)'

ga_ixes =: state_ixes 'Georgia'

NB. 'Oberserved Number'
deaths_actual =: monad : '> makenum each 2&{"1 y { excess_death_table'
deaths_expected =: monad : '> makenum each 5&{"1 y { excess_death_table'
