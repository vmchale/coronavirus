load 'tables/csv'

pop_table =: readcsv 'WPP2019_TotalPopulationBySex.csv'

get_country =: 4 : '(1 { x = (< y))'
get_year =: 4 : '(4 { x = (< y))'
get_2020 =: get_year & '2020'
filt_2020 =: (#~ (get_2020 " 1))

country_table =: monad : 'filt_2020 (#~ ((get_country & y) " 1)) pop_table'
country_total =: monad : 'makenum 8 { {. country_table y'

us_pop =: country_total 'United States of America'
it_pop =: country_total 'Italy'
fr_pop =: country_total 'France'
vn_pop =: country_total 'Viet Nam'
nz_pop =: country_total 'New Zealand'
de_pop =: country_total 'Germany'
se_pop =: country_total 'Sweden'
spain_pop =: country_total 'Spain'
NB. macau_pop =: country_total 'China, Macao SAR'
NB. taiwan_pop =: country_total 'China, Taiwan Province of China'
