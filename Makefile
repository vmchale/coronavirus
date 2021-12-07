.PHONY: clean all

.DELETE_ON_ERROR:

all: time_series_2019-ncov-Confirmed.csv time_series_2019-ncov-Deaths.csv nst-est2019-alldata.csv chicago-tested.csv chicago-cases.csv chicago-hospitalized.csv excess.csv excess-age.csv moderna.csv pfizer.csv cdc.csv janssen.csv variants.csv test.csv hosp.csv

data/COVID19Cases_geoRegion.csv data/COVID19Hosp_geoRegion.csv &:
	wget https://www.covid19.admin.ch/api/data/20211206-n9ipa928/downloads/sources-csv.zip
	unzip sources-csv.zip $@

variants.csv:
	curl -L https://raw.githubusercontent.com/myhelix/helix-covid19db/master/counts_by_state.csv -o $@

hosp.csv:
	wget https://healthdata.gov/api/views/g62h-syeh/rows.csv -O $@
	perl -i -pe 's/(\d{4})\/(\d{2})\/(\d{2})/\1-\2-\3/' $@

test.csv:
	curl -L https://healthdata.gov/api/views/j8mb-icvb/rows.csv -o $@
	perl -i -pe 's/(\d+)\/(\d+)\/(\d+)/\1-\2-\3/g' $@

all.csv:
	curl -L https://data.cdc.gov/api/views/vbim-akqf/rows.csv -o $@
	perl -i -pe 's/(\d+)\/(\d+)\/(\d+)/\1-\2-\3/g' $@

WPP2019_TotalPopulationBySex.csv:
	curl -L 'https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/CSV_FILES/WPP2019_TotalPopulationBySex.csv' -o $@

cdc.csv:
	curl -L https://data.cdc.gov/api/views/9mfq-cb36/rows.csv -o $@
	perl -i -pe 's/(\d+)\/(\d+)\/(\d+)/\3-\1-\2/' $@

nst-est2019-alldata.csv:
	curl -L https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/national/totals/nst-est2019-alldata.csv -o $@

moderna.csv:
	curl -L https://data.cdc.gov/api/views/b7pe-5nws/rows.csv -o $@
	perl -i -pe 's/(\d+)\/(\d+)\/(\d+)/\3-\1-\2/' $@

pfizer.csv:
	curl -L https://data.cdc.gov/api/views/saz5-9hgg/rows.csv -o $@
	perl -i -pe 's/(\d+)\/(\d+)\/(\d+)/\3-\1-\2/' $@

janssen.csv:
	curl -L https://data.cdc.gov/api/views/w9zu-fywh/rows.csv -o $@
	perl -i -pe 's/(\d+)\/(\d+)\/(\d+)/\3-\1-\2/' $@

excess.csv:
	curl -L https://data.cdc.gov/api/views/xkkf-xrst/rows.csv -o $@

excess-age.csv:
	curl -L https://data.cdc.gov/api/views/y5bj-9g5w/rows.csv -o $@
	perl -i -pe 's/(\d+)\/(\d+)\/(\d+)/\3-\1-\2/' $@

time_series_2019-ncov-Confirmed.csv:
	curl -L https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv -o $@

time_series_2019-ncov-Deaths.csv:
	curl -L https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv -o $@

us-states.csv:
	curl -L https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv -o $@

chicago-tested.csv:
	curl -L https://data.cityofchicago.org/resource/t4hh-4ku9.csv -o $@

chicago-cases.csv:
	curl -L https://data.cityofchicago.org/resource/naz8-j4nc.csv -o $@
	xsv sort $@ -o $@

chicago-hospitalized.csv:
	curl -L https://data.cityofchicago.org/resource/f3he-c6sv.csv -o $@

clean:
	rm -rf time_series_*.csv ilgen.csv us-states.csv nst-est2019-alldata.csv WPP2019_TotalPopulationBySex.csv chicago-tested.c* chicago-hospitalized.c* chicago-cases.c* excess.csv jdclass excess-age.csv moderna.csv pfizer.csv cdc.csv all.csv test.csv hosp.csv janssen.csv variants.csv .shake
