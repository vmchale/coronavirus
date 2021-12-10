load'jd'
jdadminx'corona'
CSVFOLDER =:'/development/j/coronavirus'

jd'csvprobe /replace excess-j.csv'
jd'csvcdefs /replace /h 1 /v 11 excess-j.csv'
jd'csvscan excess-j.csv'
jd'csvrd excess-j.csv excess'

jd'csvprobe /replace nst-est2019-alldata.csv'
jd'csvcdefs /replace /h 1 /v 20 nst-est2019-alldata.csv'
jd'csvscan nst-est2019-alldata.csv'
jd'csvrd nst-est2019-alldata.csv statePop'

NB. jd'csvrd excess-age.csv excessAge'

jd'reads /table calculated sum "Observed Number", sum "Average Expected Count" by State from excess where "Week Ending Date"> "2020-03-13" and "Week Ending Date" < "2021-11-13" and Type="Unweighted" and Outcome="All causes"'
NB. createdcol?
excess_col =: -/ ,"2 > {: jd'reads "Observed Number", "Average Expected Count" from calculated'
jd'createcol calculated excess int';excess_col

jd'ref calculated State statePop NAME'
excess_pp =: %/,"2 > {: jd'reads excess,statePop.POPESTIMATE2019 from calculated,calculated.statePop'
jd'createcol calculated excessPp float';excess_pp
jd'reads State,excessPp from calculated order by excessPp desc'

inspect =: monad define
    jd'reads "Week Ending Date","Observed Number","Average Expected Count" from excess where State="',y,'" and "Week Ending Date" >= "2020-02-29" and Type="Unweighted" and Outcome="All causes"'
)
