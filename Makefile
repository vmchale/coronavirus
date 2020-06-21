.PHONY: clean

all: time_series_2019-ncov-Confirmed.csv time_series_2019-ncov-Deaths.csv nst-est2019-alldata.csv daily.csv

docs: docs/illinois.html docs/ilgen.html

docs/%.html: %.csv
	csvtotable $< $@ -o

daily.csv:
	wget https://covidtracking.com/api/v1/states/daily.csv -O $@

WPP2019_TotalPopulationBySex.csv:
	wget 'https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/CSV_FILES/WPP2019_TotalPopulationBySex.csv' -O $@

nst-est2019-alldata.csv:
	wget http://www2.census.gov/programs-surveys/popest/datasets/2010-2019/national/totals/nst-est2019-alldata.csv -O $@

ilgen.csv: gen.ijs illinois.ijs illinois.csv
	echo "load 'gen.ijs'" | ijconsole

time_series_2019-ncov-Confirmed.csv:
	wget https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv -O $@

time_series_2019-ncov-Deaths.csv:
	wget https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv -O $@

us-states.csv:
	wget https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv -O $@

clean:
	rm -rf time_series_*.csv ilgen.csv us-states.csv nst-est2019-alldata.csv WPP2019_TotalPopulationBySex.csv daily.csv compressed

compress: compressed/daily.csv.zst

compressed/%.csv.zst: %.csv
	@mkdir -p $(dir $@)
	sak compress $< $@ --best
