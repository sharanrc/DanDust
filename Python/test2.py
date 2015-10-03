#!/usr/bin/python
import re
import time
import getch
from googleapi import getQuotes
import json

symbol=raw_input("Enter Company Symbol:");
m= re.search(r'"LastTradeWithCurrency":.*?Rs\.(.*?)"',json.dumps(getQuotes(symbols=symbol),indent=2))
print m.group(1)
