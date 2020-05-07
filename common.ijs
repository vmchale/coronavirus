load 'tables/csv'

NB. for verb 'corr'
load 'stats/base/multivariate'

sap =: 1 : '2 u ~/\ ]'

succ_diff =: - sap

daily_ratio =: % &: succ_diff

numerize =: makenum each

linear_regress =: 4 : 'y %. 1 ,. x'

splog =: (^. ` ([ & 0) @. (= & 0)) " 0

filter_zero =: (#~ (>&0))

predict_n =: dyad define
    xs =. filter_zero x
    l =. #xs
    model =. (i.l) linear_regress ^. xs
    ^ model p. (i.(l+y))
)

last_14 =: |. @ (14 & {.) @ |.

NB. first arg the smaller one
s_sbs =: dyad define
    l =. y -&:# x
    ((l$0) , x) ,: y
)

sbs =: s_sbs~ ` s_sbs @. (<&:#)

with_window =: adverb : 'u @: ]\'
NB. idk what the monadic case does
sliding_mean =: (+/ % # " 1) with_window
week_mean =: 7 & sliding_mean
