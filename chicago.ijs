load 'common.ijs'

chicago_table =: readcsv 'chicago.csv'
chicago_deaths_table =: readcsv 'chicago-deaths.csv'

get_numbers =: >@ numerize @: }. @: {:

chicago_cases =: get_numbers chicago_table
chicago_deaths =: get_numbers chicago_deaths_table

NB. https://www.census.gov/quickfacts/fact/table/chicagocityillinois/POP010210
chi_pop =: 2695598