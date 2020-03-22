NB. Data from https://dph.illinois.gov/covid19 and https://web.archive.org/web/*/https://dph.illinois.gov/covid19

load 'tables/csv'

illinois_table =: readcsv 'illinois.csv'

numerize =: makenum each

array =: > numerize }. " 1 (1 }. illinois_table)

tested =: 0 { array
positive =: 1 { array

plot_opt =: 'title Coronavirus in Illinois;xcaption Days;ycaption Number;key Tested,Positive,Dead'
il_plot =: (i. (1 { $ array)) ; (tested , positive ,: (2 { array))

positive_ratio =: positive % tested
