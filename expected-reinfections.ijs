load'states-db.ijs'

nv_pop =: 3080156

NB. sucessive differences idiom from Rosetta Code: https://rosettacode.org/wiki/Successive_prime_differences#J
succ_diff =: 2 -~/\ ]

NB. up until Aug 28 (date preprint was published)
nv_vect =: succ_diff , > (<1 1) { jd'reads "date","positive" from states where "state"="NV" and date <= "2020-08-28" order by date'

NB. day's infections, y days apart...
pairs_sep_by =: monad : '(({. , {:) " 1) y ]\ nv_vect'

mu =: monad : '(*/"1 pairs_sep_by y) % nv_pop'

nv_sep_by =: +/ @: mu
nv_tot =: +/ nv_sep_by "0 (45 + i.133)

NB. doesn't account for "interference" b/w reinfections -> if one is reinfected day 30, one cannot be reinfected day 31!
