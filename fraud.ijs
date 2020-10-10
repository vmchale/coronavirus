benf_10 =: (10&^.@+&1@%) (1+i.9)

first_digit =: monad : '{. "."0":y'
NB. , first_digit"0 smoothed_cases fl_ix

NB. by Roger Hui
histogram =: (1+i.9) & (<: @ (#/.~) @ (i.@#@[ , I.))

mk_histogram =: monad : 'histogram , first_digit"0 y'

NB. pd'type bar'
NB. pd benf_10
NB. pd'show'
