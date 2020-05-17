load 'common.ijs'

chicago_table =: readcsv 'chicago.csv'
chicago_deaths_table =: readcsv 'chicago-deaths.csv'
chicago_tested_table =: readcsv 'chicago-tested.csv'

get_numbers =: >@ numerize @: }. @: {:

chicago_cases =: get_numbers chicago_table
chicago_deaths =: get_numbers chicago_deaths_table
chicago_tested =: get_numbers chicago_tested_table

NB. 'c t' =: chicago_cases common chicago_tested
NB. (c %&succ_diff t)

NB. latest_pos =: chicago_cases %&: ({: @ succ_diff) chicago_tested

NB. https://www.census.gov/quickfacts/fact/table/chicagocityillinois/POP010210
chi_pop =: 2695598
