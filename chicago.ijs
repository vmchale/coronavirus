load 'common.ijs'
load'plot'

chicago_tested_table =: readcsv 'chicago-tested.csv'
chicago_table =: readcsv 'chicago-cases.csv'

chicago_tested_total =: > numerize }. (2&{) "1 chicago_tested_table
chicago_tested_total =: > numerize }. (3&{) "1 chicago_tested_table

chicago_cases =: > numerize }. 1&{"1 chicago_table
chicago_deaths =: > numerize }. 2&{"1 chicago_table

NB. https://www.census.gov/quickfacts/fact/table/chicagocityillinois/POP010210
chi_pop =: 2695598
