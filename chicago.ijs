load 'common.ijs'
load'plot'

chicago_table =: readcsv 'chicago.csv'
chicago_deaths_table =: readcsv 'chicago-deaths.csv'
chicago_tested_table =: readcsv 'chicago-tested.csv'

get_numbers =: >@ numerize @: }. @: {:

chicago_cases =: get_numbers chicago_table
chicago_deaths =: get_numbers chicago_deaths_table
chicago_tested =: get_numbers chicago_tested_table

'c_chicago_ t_chicago_' =: chicago_cases common chicago_tested
pp_chicago_ =: (c_chicago_ %&succ_diff t_chicago_)

NB. https://www.census.gov/quickfacts/fact/table/chicagocityillinois/POP010210
chi_pop =: 2695598
