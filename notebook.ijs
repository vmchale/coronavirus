load 'tables/csv'
load 'plot'

sap =: 1 : '2 u ~/\ ]'

succ_diff =: - sap

corona_data =: readcsv 'time_series_2019-ncov-Confirmed.csv'
deaths =: readcsv 'time_series_2019-ncov-Deaths.csv'

numerize =: makenum each

table_row =: 4 : '> numerize ((4 & }.) " 1) x { y'
get_row =: table_row & corona_data

il_ix =: 111
ny_ix =: 100

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

vn_ix =: 192

NB. to be plotted
iran_all =: prep 156
sk_all =: prep 157
italy_all =: prep 17
macau_all =: prep 195
taiwan_all =: prep 191
hk_all =: prep 184
singapore_all =: prep 3
jp_all =: prep 2
de_all =: prep 12
uk_all =: prep 404

NB. just want the data
thailand_ix =: 1
malaysia_all =: get_row 5
malaysia_ix =: 5
fr_ix =: 158

sum_columns =: {: @: (+/ " 1) @: |:

row_n =: {. $ corona_data
us_ix =: (#~ (>&0)) ((=& (<'US')) ((1 & {) " 1) corona_data) * (i.row_n)
us_total =: sum_columns (get_row us_ix)

us_deaths =: sum_columns (us_ix table_row deaths)

last_14 =: |. @ (14 & {.) @ |.

plot_opt =: 'title Observed Cases;xcaption Days;ycaption log(Cases);key Iran,SK,Italy,Vietnam,Macau,Taiwan,HK,Singapore,Germany,UK,US,Japan'
comparison_plot =: (i. $iran_all) ; (iran_all , sk_all , italy_all , (prep vn_ix) , macau_all , taiwan_all , hk_all , singapore_all , de_all , uk_all , (splog us_total) ,: jp_all)
