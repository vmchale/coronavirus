NB. Data from https://dph.illinois.gov/covid19 and https://web.archive.org/web/*/https://dph.illinois.gov/covid19

load 'tables/csv'
load 'plot'

illinois_table =: readcsv 'illinois.csv'

numerize =: makenum each
splog =: (^. ` ([ & 0) @. (= & 0)) " 0

array =: > numerize }. " 1 (1 }. illinois_table)

tested =: 0 { array
positive =: 1 { array
xs =: i. $tested

plot_opt =: 'title Coronavirus in Illinois;xcaption Days;ycaption Number;key Tested,Positive,Dead'
il_plot =: xs ; (tested , positive ,: (2 { array))

rat_option =: 'title Proportion testing Positive in Illinois;xcaption Days;ycaption Proportion'
positive_ratio =: positive % tested
