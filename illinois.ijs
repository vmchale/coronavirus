load 'plot'

load 'common.ijs'

illinois_table =: readcsv 'illinois.csv'
cook_table =: readcsv 'cook.csv'

array =: > numerize }. " 1 (}. illinois_table)
cook_num =: > numerize }. " 1 (}. chicago_table)

chi_new =: , > numerize }. " 1 }. readcsv 'chicago.csv'

tested =: 0 { array
positive =: 1 { array
deaths =: 2 { array
xs =: i. $tested

plot_opt =: 'title Coronavirus in Illinois;xcaption Days;ycaption Number;key Tested,Positive,Dead'
il_plot =: xs ; (tested , positive ,: (2 { array))

drat_option =: 'title New positive test results in Illinois;xcaption Days;ycaption Proportion'
new_positive =: (succ_diff positive) % (succ_diff tested)
xs_diff =: }: xs

last_14 =: |. @ (14 & {.) @ |.

NB. side_by_side =: (xs { prediction) ,: positive

NB. compare =: illinois_relevant ,: |. ($illinois_relevant) {. |. positive
