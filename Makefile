.PHONY: clean

all: time_series_2019-ncov-Confirmed.csv time_series_2019-ncov-Deaths.csv

time_series_2019-ncov-Confirmed.csv:
	wget https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv -O $@

time_series_2019-ncov-Deaths.csv:
	wget https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Deaths.csv -O $@

clean:
	rm -rf *.csv*
