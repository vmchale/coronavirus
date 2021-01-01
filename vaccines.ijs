load'tables/csv'
moderna =: readcsv'moderna.csv'
pfizer =: readcsv'pfizer.csv'

get_row =: dyad define
    , ((I. ((=& (< y)) "0) ({."1) x) { x)
)

NB. keep only even indices
even_ix =: monad define
    n =. $ y
    (2 * (i.(n%2))) { y
)

num_row =: dyad : 'even_ix makenum _2 }. 2 }. (x get_row y)'

NB. moderna num_row 'Chicago'
