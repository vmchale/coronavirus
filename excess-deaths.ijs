load'tables/csv'

excess_death_table =: readcsv 'Excess_Deaths_Associated_with_COVID-19.csv'

state_ixes =: monad : 'I. (=& (< y) (1&{" 1) excess_death_table)'

ga_ixes =: state_ixes 'Georgia'
ny_ixes =: state_ixes 'New York'
tx_ixes =: state_ixes 'Texas'
ok_ixes =: state_ixes 'Oklahoma'
la_ixes =: state_ixes 'Louisiana'
il_ixes =: state_ixes 'Illinois'
az_ixes =: state_ixes 'Arizona'
nj_ixes =: state_ixes 'New Jersey'
nv_ixes =: state_ixes 'Nevada'
mi_ixes =: state_ixes 'Michigan'
ma_ixes =: state_ixes 'Massachusetts'
fl_ixes =: state_ixes 'Florida'
ms_ixes =: state_ixes 'Mississippi'
co_ixes =: state_ixes 'Colorado'
sd_ixes =: state_ixes 'South Dakota'
nd_ixes =: state_ixes 'North Dakota'
wi_ixes =: state_ixes 'Wisconsin'
md_ixes =: state_ixes 'Maryland'

colize =: dyad : '> makenum each y&{"1 x { excess_death_table'
dates =: monad : '{."1 y { excess_death_table'

NB. 'Observed Number'
deaths_actual =: colize & 2
deaths_expected =: colize & 5

excess =: deaths_actual - deaths_expected
