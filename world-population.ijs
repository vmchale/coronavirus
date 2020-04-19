load 'tables/csv'

pop_table =: readcsv 'world-population.csv'

get_country =: 4 : '(0 { x = (< y))'

country_table =: monad : ', (#~ ((get_country & y) " 1)) pop_table'
country_total =: monad : 'makenum 1 { country_table y'

us_pop =: country_total 'United States of America'
it_pop =: country_total 'Italy'
fr_pop =: country_total 'France'
vn_pop =: country_total 'Viet Nam'
nz_pop =: country_total 'New Zealand'
de_pop =: country_total 'Germany'
se_pop =: country_total 'Sweden'
dk_pop =: country_total 'Denmark'
no_pop =: country_total 'Norway'
fi_pop =: country_total 'Finland'
spain_pop =: country_total 'Spain'
macau_pop =: country_total 'China, Macao SAR'
taiwan_pop =: country_total 'China, Taiwan Province of China'
