#!/usr/bin/python
import re
import time

from googleapi import getQuotes
import json
import matplotlib.pyplot as plt
symbol=raw_input("Enter Company Symbol:");
y=[];
while True:
    m= re.search(r'"LastTradeWithCurrency":.*?Rs\.(.*?)"',json.dumps(getQuotes(symbols=symbol),indent=2))
    y=[y,m];
    plt.plot(y);
    plt.show()
    time.sleep(1)

print m.group(1)
