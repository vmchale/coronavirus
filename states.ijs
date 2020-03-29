load 'tables/csv'

numerize =: makenum each

states_table =: readcsv 'us-states.csv'

row_n =: {. $states_table

state_ix =: monad define
    (#~ (>&0)) (=& (< y) (1 & {) " 1 states_table) * (i. row_n)
)

ny_ix =: state_ix 'New York'
la_ix =: state_ix 'Louisiana'
ca_ix =: state_ix 'California'
mi_ix =: state_ix 'Michigan'
al_ix =: state_ix 'Alabama'
tx_ix =: state_ix 'Texas'
ga_ix =: state_ix 'Georgia'
wa_ix =: state_ix 'Washington'
ok_ix =: state_ix 'Oklahoma'
il_ix =: state_ix 'Illinois'

cases =: > @ numerize @: (3&{) " 1
deaths =: > @ numerize @: (4&{) " 1

linear_regress =: 4 : 'y %. 1 ,. x'
