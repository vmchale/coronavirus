NB. Data from https://dph.illinois.gov/covid19 and https://web.archive.org/web/*/https://dph.illinois.gov/covid19
NB. also checked via https://covidtracking.com/data/state/illinois/

load 'tables/csv'
load 'plot'

illinois_table =: readcsv 'illinois.csv'

sap =: 1 : '2 u ~/\ ]'

succ_diff =: - sap

linear_regress =: 4 : 'y %. 1 ,. x'

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

drat_option =: 'title New positive test results in Illinois;xcaption Days;ycaption Proportion'
new_positive =: (succ_diff positive) % (succ_diff tested)
xs_diff =: }: xs

model =: xs linear_regress (^. positive)
NB. predictions one week out
prediction =: ^ model p. (i. 7 + $positive)

side_by_side =: (xs { prediction) ,: positive