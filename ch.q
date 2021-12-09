hospTable:("SD F"; enlist ",") 0: `:data/COVID19Hosp_geoRegion.csv
caseTable:("SD F"; enlist ",") 0: `:data/COVID19Cases_geoRegion.csv
/ zhPop:1408000
/ select [-10] datum,(-) prior sumTotal from caseTable where geoRegion=`ZH
