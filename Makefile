.PHONY: clean

all: time_series_2019-ncov-Confirmed.csv time_series_2019-ncov-Deaths.csv nst-est2019-alldata.csv daily.csv chicago-tested.csv chicago-cases.csv chicago-hospitalized.csv excess.csv

daily.csv:
	wget https://covidtracking.com/api/v1/states/daily.csv -O $@

WPP2019_TotalPopulationBySex.csv:
	wget 'https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/CSV_FILES/WPP2019_TotalPopulationBySex.csv' -O $@

nst-est2019-alldata.csv:
	wget https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/national/totals/nst-est2019-alldata.csv -O $@

ilgen.csv: gen.ijs illinois.ijs illinois.csv
	echo "load 'gen.ijs'" | ijconsole

excess.csv:
	wget https://data.cdc.gov/api/views/xkkf-xrst/rows.csv -O $@

excess-age.csv:
	wget https://data.cdc.gov/api/views/y5bj-9g5w/rows.csv -O $@
	sed -i 's/\([[:digit:]]\+\)\/\([[:digit:]]\+\)\/\([[:digit:]]\+\)/\3-\1-\2/' $@

time_series_2019-ncov-Confirmed.csv:
	wget https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv -O $@

time_series_2019-ncov-Deaths.csv:
	wget https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv -O $@

us-states.csv:
	wget https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv -O $@

chicago-tested.csv:
	wget https://data.cityofchicago.org/resource/t4hh-4ku9.csv -O $@

chicago-cases.csv:
	wget https://data.cityofchicago.org/resource/naz8-j4nc.csv -O $@
	xsv sort $@ -o $@

chicago-hospitalized.csv:
	wget https://data.cityofchicago.org/resource/f3he-c6sv.csv -O $@

clean:
	rm -rf time_series_*.csv ilgen.csv us-states.csv nst-est2019-alldata.csv WPP2019_TotalPopulationBySex.csv chicago-tested.csv chicago-hospitalized.csv chicago-cases.csv daily.c* excess.csv jdclass excess-age.csv

compress: compressed/daily.csv.zst

compressed/%.csv.zst: %.csv
	@mkdir -p $(dir $@)
	sak compress $< $@ --best
