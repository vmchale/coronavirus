load'common.ijs'
load'state-population.ijs'
load'plot'
load'jd'
jdadminx'corona'
CSVFOLDER =:'/development/j/coronavirus'

NB. build db
jd'csvprobe /replace daily.csv'
jd'csvcdefs /replace /h 1 daily.csv'
jd'csvscan daily.csv'
jd'csvrd daily.csv states'

NB. jd'reads "date","totalTestResults" from states where "state"="TX"'
NB. plot week_mean succ_diff , > (< 1 1) { jd'reads "date","positive" from states where "state"="FL" order by date'

deaths =: monad define
    jd'reads date,death from states where state="',y,'" and death > _9223372036854775808 order by date'
)

cases =: monad define
    jd'reads date,positive from states where state="',y,'" and positive > _9223372036854775808 order by date'
)

hospitalized =: monad define
    jd'reads date,hospitalizedCurrently from states where state="',y,'" and hospitalizedCurrently > _9223372036854775808 order by date'
)

hospitalized_cum =: monad define
    jd'reads date,hospitalizedCumulative from states where state="',y,'" and hospitalizedCurrently > _9223372036854775808 order by date'
)

smoothed_tested =: monad define
    week_mean succ_diff ,> (<1 1) { jd'reads date,totalTestResults from states where state="',y,'" and totalTestResults > _1 order by date'
)

smoothed_cases =: monad : 'week_mean succ_diff ,> (< 1 1) { cases y'
smoothed_deaths =: monad : 'week_mean succ_diff ,> (< 1 1) { deaths y'
hospitalized_plot =: monad : ',> (< 1 1) { hospitalized y'
deaths_plot =: monad : ',> (< 1 1) { deaths y'
