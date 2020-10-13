NB. load'states-db.ijs'

NB. nv_vect =: , > (<1 1) { jd'reads "date","positiveIncrease" from states where "state"="NV" order by date'
load'states.ijs'

nv_vect =: new_cases nv_ix

NB. day's infections, x days apart...
pairs_sep_by =: dyad : '(({. , {:) " 1) y ]\ x'

numerator_sep_by =: (+/ @: (*/"1) @ (nv_vect & pairs_sep_by))
numerator_tot =: +/ numerator_sep_by "0 (30 + i.192)

NB. doesn't account for "interference" b/w reinfections -> if one is reinfected day 30, one cannot be reinfected day 31!

NB. nv_pop =: 3080156
