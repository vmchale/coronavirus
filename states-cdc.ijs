load'jd'
jdadminx'corona'
CSVFOLDER =:'/development/j/coronavirus'

NB. build db
jd'csvprobe /replace cases-deaths.csv'
jd'csvcdefs /replace /h 1 cases-deaths.csv'
jd'csvscan cases-deaths.csv'
jd'csvrd cases-deaths.csv states'

load'common.ijs'

smoothed_cases =: monad define
    week_mean , > (<1 1) { jd'reads submission_date,new_case from states where state="',y,'" order by submission_date'
)

smoothed_deaths =: monad define
    week_mean , > (<1 1) { jd'reads submission_date,new_death from states where state="',y,'" order by submission_date'
)

deaths_plot =: monad define
    week_mean , > (<1 1) { jd'reads submission_date,tot_death from states where state="',y,'" order by submission_date'
)
