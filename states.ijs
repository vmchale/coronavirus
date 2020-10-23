load 'common.ijs'
load'plot'

states_table =: readcsv 'daily.csv'

table_ix =: dyad define
    I. (=& (< y) (1 & {) " 1 x)
)

state_ix =: states_table & table_ix

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
deaths =: col & 19
tested =: col & 7

hospitalized =: col & 8
hospitalized_cum =: col & 9
icu =: col & 10
icu_cum =: col & 11

with_table =: ({&states_table)

fixy =: adverb : '|. @: (u f.) @: with_table'
cases =: cases fixy
deaths =: deaths fixy
tested =: tested fixy

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
