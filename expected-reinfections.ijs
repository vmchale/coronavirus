load'states-db.ijs'

nv_pop =: 3080156

NB. up until Aug 28 (date preprint was published)
NB.
NB. sucessive differences idiom from Rosetta Code: https://rosettacode.org/wiki/Successive_prime_differences#J
nv_vect =: 2 -~/\ ] , > (<1 1) { jd'reads "date","positive" from states where "state"="NV" and date <= 20200828 order by date'

NB. day's infections, x days apart...
pairs_sep_by =: dyad : '(({. , {:) " 1) y ]\ x'

mu =: monad : '(*/"1 nv_vect pairs_sep_by y) % nv_pop'

nv_sep_by =: +/ @: mu
nv_tot =: +/ nv_sep_by "0 (45 + i.133)

NB. doesn't account for "interference" b/w reinfections -> if one is reinfected day 30, one cannot be reinfected day 31!
