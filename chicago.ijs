load 'common.ijs'
load'plot'

chicago_tested_table =: readcsv 'chicago-tested.csv'
chicago_table =: readcsv 'chicago-cases.csv'
chicago_hospitalized_table =: readcsv 'chicago-hospitalized.csv'

renumber_no_rev =: > @: numerize
renumber =: |. @: renumber_no_rev

chicago_tested_all =: renumber }. (2&{) "1 chicago_tested_table
chicago_tested_positive =: renumber }. (3&{) "1 chicago_tested_table

chicago_cases =: renumber_no_rev }. 1&{"1 chicago_table
chicago_deaths =: renumber_no_rev }. 2&{"1 chicago_table

NB. see: https://data.cityofchicago.org/Health-Human-Services/COVID-19-Hospital-Capacity-Metrics/f3he-c6sv
NB. for explanations...
chicago_hospitalized =: |: renumber }. 31&{"1 chicago_hospitalized_table
chicago_icu =: |: renumber }. 16&{"1 chicago_hospitalized_table

NB. _7 }. to drop the last n
chicago_smooth =: week_mean chicago_cases

NB. https://www.census.gov/quickfacts/fact/table/chicagocityillinois/POP010210
chi_pop =: 2695598
