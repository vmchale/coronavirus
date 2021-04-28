load'jd'
jdadminx'vaccines'
CSVFOLDER =:'/development/j/coronavirus'

jd'csvprobe /replace pfizer.csv'
jd'csvcdefs /replace /h 1 /v 30 pfizer.csv'
jd'csvscan pfizer.csv'
jd'csvrd pfizer.csv pfizer'

jd'csvprobe /replace moderna.csv'
jd'csvcdefs /replace /h 1 /v 30 moderna.csv'
jd'csvscan moderna.csv'
jd'csvrd moderna.csv moderna'

jd'csvprobe /replace janssen.csv'
jd'csvcdefs /replace /h 1 /v 30 janssen.csv'
jd'csvscan janssen.csv'
jd'csvrd janssen.csv janssen'

janssen =: jd'reads sum "1st Dose Allocations" by "Week of Allocations" from janssen'
moderna =: jd'reads sum "1st Dose Allocations" by "Week of Allocations" from moderna'
pfizer =: jd'reads sum "1st Dose Allocations" by "Week of Allocations" from pfizer'

janssen_plot =: ,>(<1 1) { janssen
moderna_plot =: ,>(<1 1) { moderna
pfizer_plot =: ,>(<1 1) { pfizer
