.PHONY: clean

all: time_series_2019-ncov-Confirmed.csv time_series_2019-ncov-Deaths.csv nst-est2019-alldata.csv daily.csv chicago-tested.csv chicago-cases.csv chicago-hospitalized.csv excess.csv excess-age.csv moderna.csv pfizer.csv cases-deaths.csv

daily.csv:
	wget https://covidtracking.com/api/v1/states/daily.csv -O $@
	perl -i -pe 's/(\d{4})(\d{2})(\d{2})/\1-\2-\3/' daily.csv

WPP2019_TotalPopulationBySex.csv:
	wget 'https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/CSV_FILES/WPP2019_TotalPopulationBySex.csv' -O $@

cases-deaths.csv:
	wget https://data.cdc.gov/api/views/9mfq-cb36/rows.csv -O $@
	perl -i -pe 's/(\d+)\/(\d+)\/(\d+)/\3-\1-\2/' $@

nst-est2019-alldata.csv:
	wget https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/national/totals/nst-est2019-alldata.csv -O $@

covidcum.csv: pre-covidcum.csv
	xsv select geo_value,time_value,value $^ > $@

pre-covidcum.csv:
	wget 'https://delphi.cmu.edu/csv?signal=indicator-combination%3Aconfirmed_cumulative_prop&start_day=2020-09-08&end_day=2020-10-31&geo_type=state' -O $@

mask-survey.csv: pre-mask-survey.csv
	xsv select geo_value,time_value,value,stderr,sample_size $^ > $@

moderna.csv:
	wget https://data.cdc.gov/api/views/b7pe-5nws/rows.csv -O $@

pfizer.csv:
	wget https://data.cdc.gov/api/views/saz5-9hgg/rows.csv -O $@

pre-mask-survey.csv:
	wget 'https://delphi.cmu.edu/csv?signal=fb-survey%3Asmoothed_wearing_mask&start_day=2020-09-08&end_day=2020-10-31&geo_type=state' -O $@

excess.csv:
	wget https://data.cdc.gov/api/views/xkkf-xrst/rows.csv -O $@

excess-age.csv:
	wget https://data.cdc.gov/api/views/y5bj-9g5w/rows.csv -O $@
	perl -i -pe 's/(\d+)\/(\d+)\/(\d+)/\3-\1-\2/' $@

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
	rm -rf time_series_*.csv ilgen.csv us-states.csv nst-est2019-alldata.csv WPP2019_TotalPopulationBySex.csv chicago-tested.c* chicago-hospitalized.c* chicago-cases.c* daily.c* excess.csv jdclass excess-age.csv mask-survey.csv pre-mask-survey.csv covidcum.csv pre-covidcum.csv moderna.csv pfizer.csv cases-deaths.csv

compress: compressed/daily.csv.zst

compressed/%.csv.zst: %.csv
	@mkdir -p $(dir $@)
	sak compress $< $@ --best
