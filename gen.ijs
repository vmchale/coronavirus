load 'illinois.ijs'

pp_row =: 'New Positive Cases' ; '-' ; (< " 0 new_positive)
new_row =: 'New Cases' ; (< " 0 succ_diff positive)
il_gen =: illinois_table , pp_row ,: new_row

il_gen writecsv 'ilgen.csv'
