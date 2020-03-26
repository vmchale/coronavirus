load 'tables/csv'
load 'plot'

sap =: 1 : '2 u ~/\ ]'

succ_diff =: - sap

corona_data =: readcsv 'time_series_2019-ncov-Confirmed.csv'
deaths =: readcsv 'time_series_2019-ncov-Deaths.csv'

numerize =: makenum each

linear_regress =: 4 : 'y %. 1 ,. x'

table_row =: 4 : '> numerize ((4 & }.) " 1) x { y'
get_row =: table_row & corona_data

corona_cols =: }. $ corona_data
col_span =: 4 }. (i.corona_cols)
col =: (< (< a:), (< col_span)) { corona_data

col_nums =: > numerize }. col
progression =: (+/ " 1) |: col_nums

NB. Have a look here for plotting info in J: https://code.jsoftware.com/wiki/Studio/Plot#Combining_different_plot_types

NB. all cases in the world
world_new =: succ_diff progression
world_plot =: (i. $progression) ; progression ,: (0 , world_new)

splog =: (^. ` ([ & 0) @. (= & 0)) " 0

prep =: splog @ get_row

NB. to be plotted
iran_ix =: 134
sk_ix =: 144
italy_ix =: 138
macau_ix =: 70
taiwan_ix =: 208
hk_ix =: 62
singapore_ix =: 197
jp_ix =: 140
de_ix =: 121
uk_ix =: 224

NB. just want the data
vn_ix =: 229
thailand_ix =: 210
malaysia_ix =: 154
fr_ix =: 117
us_ix =: 226

sum_columns =: (+/ " 1) @: |:

filter_zero =: (#~ (>&0))

row_n =: {. $ corona_data
china_ix =: (filter_zero ((=& (<'China')) ((1 & {) " 1) corona_data) * (i.row_n))
china_total =: sum_columns get_row china_ix

china_deaths =: sum_columns china_ix table_row deaths

last_14 =: |. @ (14 & {.) @ |.

plot_opt =: 'title Observed Cases;xcaption Days;ycaption log(Cases);key Iran,SK,Italy,Vietnam,Macau,Taiwan,HK,Singapore,Germany,UK,US,France,Japan'
comparison_plot =: (i. $get_row 1) ; ((prep " 0) (iran_ix , sk_ix , italy_ix , vn_ix , macau_ix , taiwan_ix , hk_ix , singapore_ix , de_ix , uk_ix , us_ix , fr_ix , jp_ix))
