load'tables/csv'
moderna =: readcsv'moderna.csv'
pfizer =: readcsv'pfizer.csv'

get_row_vax_ =: dyad define
    , ((I. ((=& (< y)) "0) ({."1) x) { x)
)

NB. keep only even indices
even_ix =: monad define
    n =. $ y
    (2 * (i.(n%2))) { y
)

num_row =: dyad : 'even_ix makenum _2 }. 2 }. (x get_row_vax_ y)'

NB. moderna num_row 'Chicago'
NB. headers_moderna =: }: even_ix {. moderna
NB. headers_pfizer =: }: even_ix {. moderna
