load 'tables/csv'

corona_data =: readcsv 'time_series_19-covid-Confirmed.csv'

headers =: {. corona_data

cols =: $ {. corona_data

new_york =: 100 { corona_data

illinois =: 111 { corona_data

numerize =: makenum each

area_numbers =: 13 : '> numerize (4 }. y)'

illinois_numbers =: area_numbers illinois
ny_numbers =: area_numbers new_york

illinois_relevant =: 48 }. illinois_numbers
illinois_log =: ^. illinois_relevant

linear_regress =: 4 : 'y %. 1 ,. x'

xs =: i.($ illinois_relevant)

model =: xs linear_regress illinois_log

prediction =: ^ model p. (i.15)
