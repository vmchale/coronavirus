load 'common.ijs'

states_table =: readcsv 'daily.csv'

table_ix =: dyad define
    row_n =. # x
    NB. replace with I.
    filter_zero (=& (< y) (1 & {) " 1 x) * (i. row_n)
)

state_ix =: states_table & table_ix

pop_table =: readcsv 'nst-est2019-alldata.csv'

pop_row_n =: # pop_table
pop_ix =: monad define
    NB. replace with I.
    <: {. filter_zero (=& (<y) (4}) " 1 pop_table) * (i. pop_row_n)
)

pop_num =: > numerize }. 16 { " 1 pop_table

la_pop =: (pop_ix 'Louisiana') { pop_num
ny_pop =: (pop_ix 'New York') { pop_num
fl_pop =: (pop_ix 'Florida') { pop_num
ca_pop =: (pop_ix 'California') { pop_num
il_pop =: (pop_ix 'Illinois') { pop_num
mi_pop =: (pop_ix 'Michigan') { pop_num
az_pop =: (pop_ix 'Arizona') { pop_num
ar_pop =: (pop_ix 'Arkansas') { pop_num
pa_pop =: (pop_ix 'Pennsylvania') { pop_num
sd_pop =: (pop_ix 'South Dakota') { pop_num
nd_pop =: (pop_ix 'North Dakota') { pop_num
ga_pop =: (pop_ix 'Georgia') { pop_num
tx_pop =: (pop_ix 'Texas') { pop_num
md_pop =: (pop_ix 'Maryland') { pop_num
va_pop =: (pop_ix 'Virginia') { pop_num
ma_pop =: (pop_ix 'Massachusetts') { pop_num
tn_pop =: (pop_ix 'Tennessee') { pop_num
ne_pop =: (pop_ix 'Nebraska') { pop_num
ia_pop =: (pop_ix 'Iowa') { pop_num
wi_pop =: (pop_ix 'Wisconsin') { pop_num
mn_pop =: (pop_ix 'Minnesota') { pop_num
in_pop =: (pop_ix 'Indiana') { pop_num
oh_pop =: (pop_ix 'Ohio') { pop_num

ny_ix =: state_ix 'NY'
la_ix =: state_ix 'LA'
ca_ix =: state_ix 'CA'
mi_ix =: state_ix 'MI'
al_ix =: state_ix 'AL'
tx_ix =: state_ix 'TX'
ga_ix =: state_ix 'GA'
wa_ix =: state_ix 'WA'
or_ix =: state_ix 'OR'
ok_ix =: state_ix 'OK'
il_ix =: state_ix 'IL'
fl_ix =: state_ix 'FL'
az_ix =: state_ix 'AZ'
ar_ix =: state_ix 'AR'
pa_ix =: state_ix 'PA'
nj_ix =: state_ix 'NJ'
sd_ix =: state_ix 'SD'
md_ix =: state_ix 'MD'
nd_ix =: state_ix 'ND'
ky_ix =: state_ix 'KY'
sc_ix =: state_ix 'SC'
nc_ix =: state_ix 'NC'
wi_ix =: state_ix 'WI'
ma_ix =: state_ix 'MA'
va_ix =: state_ix 'VA'
tn_ix =: state_ix 'TN'
ne_ix =: state_ix 'NE'
ia_ix =: state_ix 'IA'
mn_ix =: state_ix 'MN'
in_ix =: state_ix 'IN'
oh_ix =: state_ix 'OH'

filter_null =: (#~ ((-.@-:) & (<'') " 0))

col =: dyad : '> numerize filter_null (y&{) " 1 x'

cases =: col & 2
deaths =: col & 16
tested =: col & 19
recovered =: col & 11

cases =: |. @: (cases f.)
deaths =: |. @: (deaths f.)
tested =: |. @: (tested f.)
recovered =: |. @: (recovered f.)

new_cases =: succ_diff @: cases

spooky =: tested corr cases

NB. "percent positive"
pp =: cases daily_ratio tested

sliding_diff =: (7 & sliding_mean) @: succ_diff
sliding_ratio =: % &: sliding_diff
pp_sliding =: cases sliding_ratio tested
