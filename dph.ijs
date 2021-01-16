load'states-db.ijs'

jd'createtable hospitalizedCum date edate,state byte 2, hospitalizedCum int'
jd'createtable deaths date edate,state byte 2, deaths int'

hospitalized_cum_vect =: jd'reads "date","state","hospitalizedCumulative" from states'
deaths_vect =: jd'reads "date","state","death" from states'

jd'insert hospitalizedCum';'date';(>(< 1 0) { hospitalized_cum_vect);'state';(>(< 1 1) { hospitalized_cum_vect);'hospitalizedCum';(,>(< 1 2) { hospitalized_cum_vect)
jd'insert deaths';'date';(>(< 1 0) { deaths_vect);'state';(>(< 1 1) { deaths_vect);'deaths';(,>(< 1 2) { deaths_vect)

jd'ref /left hospitalizedCum date state deaths date state'

deaths_dph_ =: monad define
     , > (< 1 1) { jd'reads date,deaths.deaths from hospitalizedCum,hospitalizedCum-deaths where deaths.deaths > _9223372036854775808 and hospitalizedCum > _9223372036854775808 and state="',y,'" order by date'
)

hospitalized_cum_dph_ =: monad define
     , > (< 1 1) { jd'reads date,hospitalizedCum from hospitalizedCum,hospitalizedCum-deaths where deaths.deaths > _9223372036854775808 and hospitalizedCum > _9223372036854775808 and state="',y,'" order by date'
)

new_hosp =: succ_diff @: hospitalized_cum_dph_
new_deaths =: succ_diff @: deaths_dph_

dph =: deaths_dph_ % hospitalized_cum_dph_
dps =: {: @: dph

NB. dph =: deaths_dph_ (% &: succ_diff) hospitalized_cum_dph_
