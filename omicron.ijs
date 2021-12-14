load'jd'
jdadminx'omicron'
CSVFOLDER =:'~/dev/j/coronavirus'

jd'csvprobe /replace omicron.csv'
jd'csvcdefs /replace /h 1 omicron.csv'
jd'csvscan omicron.csv'
jd'csvrd omicron.csv omicron'
