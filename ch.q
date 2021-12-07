hosp:`:data/COVID19Hosp_geoRegion.csv
hospTable("SD F"; enlist ",") 0: hosp
case:`:data/COVID19Cases_geoRegion.csv
caseTable:("SD F"; enlist ",") 0: case
/ zhPop:1408000
/ select [-10] datum,(-) prior sumTotal from caseTable where geoRegion=`ZH
