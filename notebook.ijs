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

prediction =: ^ model p. (i.15)
prediction_ny =: ^ model_ny p. (i.15)

death_prediction =: ^ death_model p. (i.14)

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
world_new_cases =: succ_diff progression
world_plot =: (i. $progression) ; progression ,: (0 , world_new_cases)

vn_data =: > numerize 5 }. 192 { corona_data
vn_plot =: (i. $vn_data) ; vn_data

sk_data =: > numerize 4 }. 157 { corona_data
iran_data =: > numerize 32 }. 156 { corona_data
