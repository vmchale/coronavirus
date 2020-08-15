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
name_ixes =: 3 : 'I. ((=& (<y)) country_names)'
name_ix =: {: @: name_ixes

NB. two-letter abbreviations based on domain codes
au_ixes =: name_ixes 'Australia'
ca_ixes =: name_ixes 'Canada'
cn_ixes =: name_ixes 'China'
us_ix =: name_ix 'US'
vn_ix =: name_ix 'Vietnam'
sg_ix =: name_ix 'Singapore'
be_ix =: name_ix 'Belgium'
fr_ix =: name_ix 'France'
uk_ix =: name_ix 'United Kingdom'
de_ix =: name_ix 'Germany'
nl_ix =: name_ix 'Netherlands'
es_ix =: name_ix 'Spain'
sg_ix =: name_ix 'Singapore'
sk_ix =: name_ix 'Korea, South'
jp_ix =: name_ix 'Japan'
it_ix =: name_ix 'Italy'
se_ix =: name_ix 'Sweden'
dk_ix =: name_ix 'Denmark'
fi_ix =: name_ix 'Finland'
no_ix =: name_ix 'Norway'

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

NB. us fit 'title Deaths in the US;key Actual,Fitted;xcaption Days;ycaption log(Cases)' plot (^. filter_zero get_deaths us_ix) ,: (^. (get_deaths us_ix) predict_n 0)
NB. 'key Norway,Finland,Denmark,Sweden;xcaption Days;ycaption Deaths;title Deaths per thousand persons' plot ((get_deaths no_ix) % no_pop) , ((get_deaths fi_ix) % fi_pop) , ((get_deaths dk_ix) % dk_pop) ,: ((get_deaths se_ix) % se_pop)
