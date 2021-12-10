import pandas as pd

from time import time

excess_table = pd.read_csv("excess-j.csv")
pop_table = pd.read_csv("nst-est2019-alldata.csv").rename(columns={"NAME": "State"})

t = time()

for i in range(100):
    # augment with difference column
    excess_table["Excess"] = excess_table["Observed Number"]-excess_table["Average Expected Count"]
    filtered = excess_table[(excess_table["Type"] == "Unweighted") & (excess_table["Outcome"] == "All causes") & (excess_table["Week Ending Date"] > "2020-03-13") & (excess_table["Week Ending Date"] < "2021-11-13")]
    joined = filtered.groupby("State").sum().merge(pop_table, left_on="State", right_on="State", how="inner")
    joined["Excess Per Person"] = joined["Excess"] / joined["POPESTIMATE2019"]
    joined[["State", "Excess Per Person"]].sort_values(by="Excess Per Person", ascending=False)

delta = time() - t
print('t: %0.2fs' % delta)
