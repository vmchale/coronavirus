load 'tables/csv'
load 'plot'

sap =: 1 : '2 u ~/\ ]'

succ_diff =: - sap

corona_data =: readcsv 'time_series_2019-ncov-Confirmed.csv'
deaths =: readcsv 'time_series_2019-ncov-Deaths.csv'

new_york =: 100 { corona_data

illinois =: 111 { corona_data

numerize =: makenum each

area_numbers =: 13 : '> numerize (4 }. y)'

table_row =: 4 : '> numerize ((4 & }.) " 1) x { y'
get_row =: table_row & corona_data

illinois_numbers =: area_numbers illinois
ny_numbers =: area_numbers new_york

illinois_relevant =: 48 }. illinois_numbers
ny_relevant =: 48 }. ny_numbers

ny_deaths =: > numerize 56 }. 100 { deaths

illinois_log =: ^. illinois_relevant
ny_log =: ^. ny_relevant

linear_regress =: 4 : 'y %. 1 ,. x'

xs =: i.($ illinois_relevant)

xs_deaths =: i.($ ny_deaths)

model =: xs linear_regress illinois_log
model_ny =: xs linear_regress ny_log

death_model =: xs_deaths linear_regress (^. ny_deaths)

prediction =: ^ model p. (i. 7 + $illinois_relevant)
prediction_ny =: ^ model_ny p. (i. 7 + $ny_relevant)

death_prediction =: ^ death_model p. (i. 7 + $ny_deaths)

corona_cols =: }. $ corona_data
col_span =: 4 }. (i.corona_cols)
col =: (< (< a:), (< col_span)) { corona_data

col_nums =: > numerize }. col
progression =: (+/ " 1) |: col_nums

NB. Have a look here for plotting info in J: https://code.jsoftware.com/wiki/Studio/Plot#Combining_different_plot_types

illinois_new_cases =: succ_diff illinois_relevant

NB. show illinois confirmed results vs. exponential model
illinois_plot =: xs ; illinois_relevant ,: (xs { prediction)

ny_death_plot =: xs_deaths ; ny_deaths ,: (xs_deaths { death_prediction)

NB. all cases in the world
world_new =: succ_diff progression
world_plot =: (i. $progression) ; progression ,: (0 , world_new)

splog =: (^. ` ([ & 0) @. (= & 0)) " 0

prep =: splog @ get_row

NB. to be plotted
iran_all =: prep 156
sk_all =: prep 157
italy_all =: prep 17
vn_all =: get_row 192
macau_all =: prep 195
taiwan_all =: prep 191
hk_all =: prep 184
singapore_all =: prep 3
jp_all =: prep 2
de_all =: prep 12
uk_all =: prep 404

NB. just want the data
NB. thailand_all =: get_row 1
malaysia_all =: get_row 5
NB. fr_all =: get_row 158

sum_columns =: {: @: (+/ " 1) @: |:

row_n =: {. $ corona_data
us_ix =: (#~ (>&0)) ((=& (<'US')) ((1 & {) " 1) corona_data) * (i.row_n)
us_total =: sum_columns (get_row us_ix)

us_deaths =: sum_columns (us_ix table_row deaths)

last_14 =: |. @ (14 & {.) @ |.
us_sample =: last_14 us_total

us_model =: (i. 14) linear_regress (splog us_sample)
us_predict =: ^ us_model p. (i. 21)

vn_data =: 1 }. vn_all
vn_plot =: (i. $vn_data) ; vn_data

NB. iran_data =: 28 }. iran_all

plot_opt =: 'title Observed Cases;xcaption Days;ycaption log(Cases);key Iran,SK,Italy,Vietnam,Macau,Taiwan,HK,Singapore,Germany,UK,US,Japan'
comparison_plot =: (i. $iran_all) ; (iran_all , sk_all , italy_all , splog vn_all , macau_all , taiwan_all , hk_all , singapore_all , de_all , uk_all , (splog us_total) ,: jp_all)
