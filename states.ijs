load 'common.ijs'
load'plot'

states_table =: readcsv 'daily.csv'

table_ix =: dyad define
    I. (=& (< y) (1 & {) " 1 x)
)

state_ix =: states_table & table_ix

pop_table =: readcsv 'nst-est2019-alldata.csv'

pop_ix =: monad define
    NB. replace with I.
    <: {. I. (=& (<y) (4}) " 1 pop_table)
)

pop_num =: > numerize }. 16 { " 1 pop_table

la_pop =: (pop_ix 'Louisiana') { pop_num
ny_pop =: (pop_ix 'New York') { pop_num
nj_pop =: (pop_ix 'New Jersey') { pop_num
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
ms_ix =: state_ix 'MS'
wy_ix =: state_ix 'WY'
dc_ix =: state_ix 'DC'
mo_ix =: state_ix 'MO'
co_ix =: state_ix 'CO'
wv_ix =: state_ix 'WV'
mt_ix =: state_ix 'MT'
ct_ix =: state_ix 'CT'
ri_ix =: state_ix 'RI'
nv_ix =: state_ix 'NV'
nm_ix =: state_ix 'NM'
ut_ix =: state_ix 'UT'
me_ix =: state_ix 'ME'
ks_ix =: state_ix 'KS'
id_ix =: state_ix 'ID'

filter_null =: (#~ ((-.@-:) & (<'') " 0))

col =: dyad : '> numerize filter_null (y&{) " 1 x'

cases =: col & 2
deaths =: col & 18
tested =: col & 5
recovered =: col & 11

hospitalized =: col & 6
hospitalized_cum =: col & 7
icu =: col & 8
icu_cum =: col & 9

with_table =: ({&states_table)

fixy =: adverb : '|. @: (u f.) @: with_table'
cases =: cases fixy
deaths =: deaths fixy
tested =: tested fixy
recovered =: recovered fixy

hospitalized =: hospitalized fixy
hospitalized_cum =: hospitalized_cum fixy
icu =: icu fixy
icu_cum =: icu_cum fixy

new_cases =: succ_diff @: cases
new_deaths =: succ_diff @: deaths

smoothed_cases =: week_mean @: new_cases
smoothed_deaths =: week_mean @: new_deaths

spooky =: tested corr cases

NB. "percent positive"
pp =: cases daily_ratio tested
pp_match =: monad define
    'c t' =. (cases y) common (tested y)
    c daily_ratio t
)

pp_sliding =: week_mean @: pp
pp_match_sliding =: week_mean @: pp_match
