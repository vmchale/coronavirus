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

vn_ix =: 229

NB. to be plotted
iran_all =: prep 134
sk_all =: prep 144
italy_all =: prep 138
macau_all =: prep 70
taiwan_all =: prep 208
hk_all =: prep 62
singapore_all =: prep 197
jp_all =: prep 140
de_all =: prep 121
uk_all =: prep 224

NB. just want the data
thailand_ix =: 1
malaysia_all =: get_row 5
malaysia_ix =: 5
fr_ix =: 158

row_n =: {. $ corona_data
us_ix =: {. ((#~ (>&0)) ((=& (<'US')) ((1 & {) " 1) corona_data) * (i.row_n))
us_total =: get_row us_ix

us_deaths =: us_ix table_row deaths

last_14 =: |. @ (14 & {.) @ |.

plot_opt =: 'title Observed Cases;xcaption Days;ycaption log(Cases);key Iran,SK,Italy,Vietnam,Macau,Taiwan,HK,Singapore,Germany,UK,US,Japan'
comparison_plot =: (i. $iran_all) ; (iran_all , sk_all , italy_all , (prep vn_ix) , macau_all , taiwan_all , hk_all , singapore_all , de_all , uk_all , (splog us_total) ,: jp_all)
