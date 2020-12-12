load'states-db.ijs'

nv_pop =: 3080156

NB. sucessive differences idiom from Rosetta Code: https://rosettacode.org/wiki/Successive_prime_differences#J
succ_diff =: 2 -~/\ ]

NB. up until Aug 28 (date preprint was published)
nv_vect =: succ_diff , > (<1 1) { jd'reads "date","positive" from states where "state"="NV" and date <= "2020-08-28" order by date'

NB. day's infections, y days apart...
pairs_sep_by =: monad : '(({. , {:) " 1) y ]\ nv_vect'

mu =: dyad : '(*/"1 pairs_sep_by y) % x'

nv_sep_by =: +/ @: (nv_pop & mu)
nv_tot =: +/ nv_sep_by "0 (45 + i.133)

NB. doesn't account for "interference" b/w reinfections -> if one is reinfected day 30, one cannot be reinfected day 31!

NB. from https://www.sciencedirect.com/science/article/pii/S1477893920304440?via%3Dihub
NB. published 8 December 2020
NB. around 0.04% PCR thingy-s are sequenced
pe_rho =: 0.0004
NB. from the UN stuff
pe_pop =: 3.29718e7

load'notebook.ijs'
pe_vect =: succ_diff (i.322) { get_row pe_ix
pe_sep_by =: +/ @: (pe_pop & mu)
pe_tot =: +/ pe_sep_by "0 (45 + i.278)
