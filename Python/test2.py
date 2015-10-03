#!/usr/bin/python
import re
import time
import getch
import kbh
from googleapi import getQuotes
import json

kb=kbh.KBHit()
symbol=raw_input("Enter Company Symbol:");
m= re.search(r'"LastTradeWithCurrency":.*?Rs\.(.*?)"',json.dumps(getQuotes(symbols=symbol),indent=2))
print m.group(1)
while True:
    key==kb.kbhit()
    if (key==27):
        break;
    time.sleep(1)
    print m.group(1)
