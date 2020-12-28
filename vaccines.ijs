load'tables/csv'
moderna =: readcsv'moderna.csv'
pfizer =: readcsv'pfizer.csv'

get_row =: dyad define
    , ((I. ((=& (< y)) "0) ({."1) x) { x)
)
