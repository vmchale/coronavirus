load 'common.ijs'
load'plot'

chicago_tested_table =: readcsv 'chicago-tested.csv'
chicago_table =: readcsv 'chicago-cases.csv'

renumber =: |. @: > @: numerize

chicago_tested_total =: renumber }. (2&{) "1 chicago_tested_table
chicago_tested_total =: renumber }. (3&{) "1 chicago_tested_table

chicago_cases =: renumber }. 1&{"1 chicago_table
chicago_deaths =: renumber }. 2&{"1 chicago_table

NB. _7 }. to drop the last n
chicago_smooth =: week_mean chicago_cases

NB. https://www.census.gov/quickfacts/fact/table/chicagocityillinois/POP010210
chi_pop =: 2695598
