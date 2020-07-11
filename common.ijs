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

NB. first arg the smaller one
s_sbs =: dyad define
    l =. y -&:# x
    ((l$0) , x) ,: y
)

last_n =: adverb : '(- x) & {.'

last_14 =: _14 & {.

NB. Used like so:
NB.
NB. (cases az_ix) last_k_predict_n (14;7) to use the last 14 days to predict the next 7
last_k_predict_n =: dyad define
    'k n' =. y
    l =. #x
    model =. (k last_n (i.l)) linear_regress ^. (k last_n x)
    ^ model p. (i.(l+n))
)

common =: dyad define
    sel =. y <.&# x
    x (,:&(sel last_n)) y
)

ccat =: dyad define
    max_dim =. >./@:$
    sel =. y <.&max_dim x
    x (,&:(sel last_n " 1)) y
)

clink =: dyad define
    sel =. y <.&# x
    x (;&(sel last_n)) y
)

sbs =: s_sbs~ ` s_sbs @. (<&:#)

with_window =: adverb : 'u @: ]\'
arithmetic_means_ =: +/ % #
NB. better b/c overflows on fewer things
geometric_means_ =: arithmetic_means_ &.: ^.
NB. harmonic_means_ =: arithmetic_means_ &.: %

NB. idk what the monadic case does
sliding_mean =: (arithmetic_means_ " 1) with_window
week_mean =: 7 & sliding_mean
