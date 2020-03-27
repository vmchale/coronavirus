load 'tables/csv'

numerize =: makenum each

states_table =: readcsv 'us-states.csv'

row_n =: {. $states_table

ny_ix =: (#~ (>&0)) ((=& (<'New York')) (1 & {) " 1 states_table) * (i. row_n)

cases =: > @ numerize @: (3&{) " 1
deaths =: > @ numerize @: (4&{) " 1

linear_regress =: 4 : 'y %. 1 ,. x'
