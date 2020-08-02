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

NB. two-letter abbreviations based on domain codes
iran_ix =: 134
be_ix =: 24
sk_ix =: 144
it_ix =: 138
macau_ix =: 70
taiwan_ix =: 208
hk_ix =: 62
sg_ix =: 197
jp_ix =: 140
de_ix =: 121
uk_ix =: 224
dk_ix =: 95
no_ix =: 176
fi_ix =: 107
spain_ix =: 202
india_ix =: 132

vn_ix =: 229
thailand_ix =: 210
malaysia_ix =: 154
fr_ix =: 117
us_ix =: 226
nz_ix =: 171
nigeria_ix =: 174
se_ix =: 206
br_ix =: 29
is_ix =: 131
greece_ix =: 123
russia_ix =: 188
nl_ix =: 170
kenya_ix =: 143

country_names =: ((1 & {) " 1) corona_data
name_ixes =: 3 : 'I. ((=& (<y)) country_names)'

au_ixes =: name_ixes 'Australia'
ca_ixes =: name_ixes 'Canada'
cn_ixes =: name_ixes 'China'

sum_columns =: (+/ " 1) @: |:

row_n =: {. $ corona_data

china_total =: sum_columns get_row cn_ixes
china_deaths =: sum_columns get_deaths cn_ixes

plot_opt =: 'title Observed Cases;xcaption Days;ycaption log(Cases);key Iran,SK,Italy,Vietnam,Macau,Taiwan,HK,Singapore,Germany,UK,US,France,Japan'
comparison_plot =: (prep " 0) (iran_ix , sk_ix , it_ix , vn_ix , macau_ix , taiwan_ix , hk_ix , sg_ix , de_ix , uk_ix , us_ix , fr_ix , jp_ix)

plot_us =: 'title Confirmed Cases;xcaption Days;ycaption Cases;key China,US,Italy'
compare_us =: china_total , (get_row us_ix) ,: (get_row it_ix)

new_cases =: succ_diff @: get_row
new_deaths =: succ_diff @: get_deaths

smoothed_cases =: week_mean @: new_cases
smoothed_deaths =: week_mean @: new_deaths

NB. (* & population)
ltransform =: % @: >: @: ^ @: -
linv =: ltransform ^: _1

NB. us fit 'title Deaths in the US;key Actual,Fitted;xcaption Days;ycaption log(Cases)' plot (^. filter_zero get_deaths us_ix) ,: (^. (get_deaths us_ix) predict_n 0)
NB. 'key Norway,Finland,Denmark,Sweden;xcaption Days;ycaption Deaths;title Deaths per thousand persons' plot ((get_deaths no_ix) % no_pop) , ((get_deaths fi_ix) % fi_pop) , ((get_deaths dk_ix) % dk_pop) ,: ((get_deaths se_ix) % se_pop)
