#!/usr/bin/python
import urllib2
from urllib2 import URLError
from sets import Set
def download(url, file):
	try:
		response = urllib2.urlopen(url)
		body = response.read()
		out = open(file, 'wb')
		out.write(body)
	except URLError, err:
		print(err.reason)
downloaded = Set() 
f = open("list.txt")
for line in f:
	downloaded.add(line.strip())	
#print(html)
download("https://lh5.ggpht.com/-4M_Ri2Qk9y0sZkZhWcE3-X4nKO2fzgJvBNsr-WtSHffJG8hacjlWFjABomBWChA5w=h900", "/tmp/test.jpg")
