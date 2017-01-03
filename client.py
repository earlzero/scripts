import time
import datetime
import struct
import json
from RF24 import *
import RPi.GPIO as GPIO
import requests
state = {}
start = time.time()
radio = RF24(22, 0);
address=0xABCDABCD71
radio.begin();
radio.printDetails();
radio.openReadingPipe(1, address);
radio.startListening();

start = time.time()
while(True):
        timeout = False
        while(not radio.available()):
                if time.time() - start > 3:
                        timeout = True
                        break
        if timeout:
		pass
        else:
                payload = radio.read(14)
                id, count =  struct.unpack("bb", payload[:2])
                t0, t1, t2 =  struct.unpack("fff", payload[2:])
		state[id] = { "time": str(datetime.datetime.now()), "temp":[t0,t1]}
		if time.time() - start > 150:
			try:
				start = time.time()
				requests.post("https://", data = json.dumps(state), verify = False)
			except Exception as e:
				print(e)

