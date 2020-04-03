load 'common.ijs'

states_table =: readcsv 'us-states.csv'

row_n =: # states_table

state_ix =: monad define
    filter_zero (=& (< y) (1 & {) " 1 states_table) * (i. row_n)
)

pop_table =: readcsv 'nst-est2019-alldata.csv'

pop_row_n =: # pop_table
pop_ix =: monad define
    <: {. filter_zero (=& (<y) (4}) " 1 pop_table) * (i. pop_row_n)
)

pop_num =: > numerize }. 16 { " 1 pop_table

la_pop =: (pop_ix 'Louisiana') { pop_num
ny_pop =: (pop_ix 'New York') { pop_num
fl_pop =: (pop_ix 'Florida') { pop_num
ca_pop =: (pop_ix 'California') { pop_num
il_pop =: (pop_ix 'Illinois') { pop_num

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
fl_ix =: state_ix 'Florida'

scaled_deaths =: 3 : '(filter_zero deaths (state_ix y) { states_table) % ((pop_ix y) { pop_num)'

cases =: > @ numerize @: (3&{) " 1
deaths =: > @ numerize @: (4&{) " 1