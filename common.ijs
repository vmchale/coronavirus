load 'tables/csv'

sap =: 1 : '2 u ~/\ ]'

succ_diff =: - sap

numerize =: makenum each

linear_regress =: 4 : 'y %. 1 ,. x'

splog =: (^. ` ([ & 0) @. (= & 0)) " 0

filter_zero =: (#~ (>&0))

predict_n =: dyad define
    xs =. filter_zero x
    l =. $xs
    model =. (i.l) linear_regress ^. xs
    ^ model p. (i.(l+y))
)
