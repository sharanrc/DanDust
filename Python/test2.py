#!/usr/bin/python
import re
import urllib
base_url = 'http://finance.google.com/finance?q=goog'

content = urllib.urlopen(base_url).read()
#line=f.readline()
#while line :
#line=f.readline()
mathcc= re.fin('id="ref_665234_l">.+?>(.*?)<',content)

mathc= re.search('id="ref_665234(.*?)">\(*(.*?)\)*?<',content)
if(mathc):
    print mathc.group(1)
    print mathc.group(2)
if(mathcc):

    print mathcc.group(1)
