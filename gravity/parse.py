#!/usr/bin/python
# -*- coding: utf-8 -*-
import re
f = open("/tmp/gravity.txt")
s = f.read()
out = open("/tmp/result.csv", "w")
lines = re.findall('<td.*?>(.*?)<\/td>', s)
for i in range(25,len(lines), 4):
	name = lines[i].replace('/"/','').replace("'","")
	m = re.search("лонгборд|дека|ЛОНГБОРД|ДЕКА", name)	
	if(m):
		out.write(name+";"+lines[i+1]+"\n")
out.close()
