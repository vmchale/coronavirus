load 'plot'

load 'common.ijs'

illinois_table =: readcsv 'illinois.csv'

array =: > numerize }. " 1 (}. illinois_table)

tested =: 0 { array
positive =: 1 { array
deaths =: 2 { array
xs =: i. $tested

plot_opt =: 'title Coronavirus in Illinois;xcaption Days;ycaption Number;key Tested,Positive,Dead'
il_plot =: xs ; (tested , positive ,: (2 { array))

new_positive =: (succ_diff positive) % (succ_diff tested)
illinois_smooth =: week_mean succ_diff positive
