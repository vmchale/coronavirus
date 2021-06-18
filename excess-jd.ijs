load'jd'
jdadminx'corona'
CSVFOLDER =:'/development/j/coronavirus'

NB. jd'csvprobe /replace excess.csv'
NB. jd'csvcdefs /replace /h 1 /v 11 excess.csv'
NB. jd'csvscan excess.csv'
jd'csvrd excess.csv excess'

jd'csvrd excess-age.csv excessAge'

NB. jd'reads "Week Ending Date","Observed Number","Average Expected Count" from excess where State="United States" and "Week Ending Date" >= "2020-02-29" and Type="Predicted (weighted)" and Outcome="All causes"'

decolumnize =: ,@:>@{:

inspect =: monad define
    jd'reads "Week Ending Date","Observed Number","Average Expected Count" from excess where State="',y,'" and "Week Ending Date" >= "2020-02-29" and Type="Unweighted" and Outcome="All causes"'
)

deaths_state =: dyad define
    -/,> {: jd'reads sum "Observed Number",sum "Average Expected Count" from excess where State="',x,'" and "Week Ending Date" >= "2020-02-29" and "Week Ending Date" <= "',y,'" and Type="Unweighted" and Outcome="All causes"'
)

load'states.ijs'
load'state-population.ijs'

deaths_vect =: 3 : '(deaths_state&y@>) states'
nyc_excess =: monad define
    ('New York City'deaths_state y)%nyc_pop
)
pop_vect =: pop_state@> states
deaths_present =: monad define
    key =. (deaths_vect y)%pop_vect
    (\: key) { |: states,:<"0 key
)
NB.
NB. ((deaths_state&'2021-02-06'%pop_state)@>) states
