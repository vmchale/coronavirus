load'jd'
jdadminx'corona'
CSVFOLDER =:'/development/j/coronavirus'

jd'csvrd mask-survey.csv masking'
jd'renamecol masking geo_value state'

jd'csvrd covidcum.csv covidCumulative'

vector_date =: monad define
    ,> (< 1 1) { jd'reads geo_value,value from covidCumulative where time_value="',y,'"'
)

delta =: -&: vector_date

states =: > (< 1 0) { jd'reads geo_value from covidCumulative where time_value="2020-10-09"' NB. pick an arbitrary date

NB. create table so we can join
jd'createtable newCases';'state byte 2';'newCases float'
jd'insert newCases';'state';states;'newCases';('2020-10-18' delta '2020-10-11')

NB. from Stokes book https://www.jsoftware.com/help/learning/24.htm
mu =: +/ % #
norm =: -mu
var =: mu @: *: @: norm
sigma =: %: @: var
cov =: mu @: (*&norm)
r =: cov % (*&sigma)

jd'ref /left newCases state masking state'

NB. jd'reads state,newCases,masking.value from newCases,newCases-masking where masking.time_value="2020-10-11"'
cases =: ,> (< 1 1) { jd'reads state,newCases,masking.value from newCases,newCases-masking where masking.time_value="2020-10-04"'
masks =: ,> (< 1 2) { jd'reads state,newCases,masking.value from newCases,newCases-masking where masking.time_value="2020-10-04"'
