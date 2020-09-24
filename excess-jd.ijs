load'jd'
jdadminx'corona'
CSVFOLDER =:'/home/vanessa/programming/j/coronavirus'

jd'csvprobe /replace Excess_Deaths_Associated_with_COVID-19.csv'
jd'csvcdefs /replace /h 1 Excess_Deaths_Associated_with_COVID-19.csv'
jd'csvscan Excess_Deaths_Associated_with_COVID-19.csv'
jd'csvrd Excess_Deaths_Associated_with_COVID-19.csv excess'

NB. get observed and expected data
NB. jd'reads "Week Ending Date","Observed Number","Average Expected Count" from excess where State="Texas" and "Week Ending Date" >= "2020-02-29"'
