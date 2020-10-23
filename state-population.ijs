load'common.ijs'

pop_table =: readcsv 'nst-est2019-alldata.csv'

pop_ix =: monad define
    NB. replace with I.
    <: {. I. (=& (<y) (4}) " 1 pop_table)
)

pop_num =: > numerize }. 16 { " 1 pop_table

pop_state =: monad : '(pop_ix y) { pop_num'

la_pop =: pop_state'Louisiana'
ny_pop =: pop_state'New York'
nj_pop =: pop_state'New Jersey'
fl_pop =: pop_state'Florida'
ca_pop =: pop_state'California'
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
ms_pop =: (pop_ix 'Mississippi') { pop_num
wy_pop =: (pop_ix 'Wyoming') { pop_num
al_pop =: (pop_ix 'Alabama') { pop_num
nc_pop =: (pop_ix 'North Carolina') { pop_num
sc_pop =: (pop_ix 'South Carolina') { pop_num
ok_pop =: (pop_ix 'Oklahoma') { pop_num
nv_pop =: (pop_ix 'Nevada') { pop_num
ut_pop =: (pop_ix 'Utah') { pop_num
or_pop =: (pop_ix 'Oregon') { pop_num
mt_pop =: (pop_ix 'Montana') { pop_num
ct_pop =: (pop_ix 'Connecticut') { pop_num
wa_pop =: (pop_ix 'Washington') { pop_num
ky_pop =: (pop_ix 'Kentucky') { pop_num
me_pop =: (pop_ix 'Maine') { pop_num
ri_pop =: (pop_ix 'Rhode Island') { pop_num
ks_pop =: (pop_ix 'Kansas') { pop_num
id_pop =: (pop_ix 'Idaho') { pop_num
