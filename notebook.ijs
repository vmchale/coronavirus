load 'plot'

load 'common.ijs'

corona_data =: readcsv 'time_series_2019-ncov-Confirmed.csv'
deaths =: readcsv 'time_series_2019-ncov-Deaths.csv'

table_row =: 4 : '> numerize ((4 & }.) " 1) x { y'
get_row =: table_row & corona_data
get_deaths =: (table_row & deaths) f.

corona_cols =: }. $ corona_data
col_span =: 4 }. (i.corona_cols)
col =: (< (< a:), (< col_span)) { corona_data

col_nums =: > numerize }. col
progression =: (+/ " 1) |: col_nums

NB. Have a look here for plotting info in J: https://code.jsoftware.com/wiki/Studio/Plot#Combining_different_plot_types

NB. all cases in the world
world_new =: succ_diff progression
world_plot =: (i. $progression) ; progression ,: (0 , world_new)

prep =: splog @ get_row

country_names =: ((1 & {) " 1) corona_data
province_names =: {."1 corona_data
name_ixes =: 3 : 'I. ((=& (<y)) country_names)'
name_ix =: {: @: name_ixes
province_ix =: 3 : '{. I. ((=& (<y)) province_names)'

NB. two-letter abbreviations based on domain codes
au_ixes =: name_ixes 'Australia'
ca_ixes =: name_ixes 'Canada'
cn_ixes =: name_ixes 'China'
us_ix =: name_ix 'US'
vn_ix =: name_ix 'Vietnam'
sg_ix =: name_ix 'Singapore'
be_ix =: name_ix 'Belgium'
uk_ix =: name_ix 'United Kingdom'
de_ix =: name_ix 'Germany'
es_ix =: name_ix 'Spain'
sg_ix =: name_ix 'Singapore'
sk_ix =: name_ix 'Korea, South'
jp_ix =: name_ix 'Japan'
it_ix =: name_ix 'Italy'
se_ix =: name_ix 'Sweden'
dk_ix =: name_ix 'Denmark'
fi_ix =: name_ix 'Finland'
no_ix =: name_ix 'Norway'
nz_ix =: name_ix 'New Zealand'
br_ix =: name_ix 'Brazil'
hk_ix =: province_ix 'Hong Kong'
fr_ix =: 127
nl_ix =: name_ix 'Netherlands'
sn_ix =: name_ix 'Senegal'
za_ix =: name_ix 'South Africa'
in_ix =: name_ix 'India'
ru_ix =: name_ix 'Russia'
rw_ix =: name_ix 'Rwanda'
my_ix =: name_ix 'Malaysia'
th_ix =: name_ix 'Thailand'
pe_ix =: name_ix 'Peru'

sum_columns =: (+/ " 1) @: |:

row_n =: {. $ corona_data

china_total =: sum_columns get_row cn_ixes
china_deaths =: sum_columns get_deaths cn_ixes

new_cases =: succ_diff @: get_row
new_deaths =: succ_diff @: get_deaths

smoothed_cases =: week_mean @: new_cases
smoothed_deaths =: week_mean @: new_deaths

NB. (* & population)
ltransform =: % @: >: @: ^ @: -
linv =: ltransform ^: _1
