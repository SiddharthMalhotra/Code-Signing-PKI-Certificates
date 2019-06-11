from urllib.request import urlopen
from urllib.error import HTTPError
from socket import create_connection
from os.path import isfile
from sys import exit

import requests
import json
import requests
import time
import os
import errno
#import rhinoscriptsyntax as rs

def mkdir_p(path):
	
	try:
		os.makedirs(path)
	except OSError as exc: 
		if exc.errno == errno.EEXIST and os.path.isdir(path):
			pass


def receiveresource(lines, filenumber):

	apikey = "24ade3b7ca7e1d3cb80b95925460085d93dcb61fcde9f796e93d0084dd488209"
	url = 'https://www.virustotal.com/vtapi/v2/file/report'
	counter=1
	setcounter = 1

	hashes_path = './Malware_Hashes'
	winhash_name = "windows_virushashes_%d.txt"%filenumber
	mkdir_p(hashes_path)
	
	responses_path= './Virustotal_Responses/'
	responses_name = "responses_windows_virushashes_%d.json"%filenumber
	mkdir_p(responses_path)

	if((os.path.exists(os.path.join(hashes_path, winhash_name)))== True):

		print('It exists')
		with open(os.path.join(hashes_path, winhash_name), "r") as starter: 
			last_line = starter.readlines()[-1].rstrip('\n').strip()
			print(last_line)
			print(type(last_line))
			count_raw_hashes = len(lines)

		for item in lines:
			setcounter+=1
			if(item.rstrip('\n').strip() == last_line):
				print('True')
				print(setcounter)
				setitem = item
				print(setitem)
				time.sleep(0.1)
				break
			

		splicelist = lines[setcounter-1:]
		

		for item in splicelist:
			time.sleep(0.02)
			print('Checking item...',setcounter,"...", item)
			resource = item
			params = {'apikey': apikey, 'resource': resource, 'allinfo': 1}
			response = requests.get(url, params=params).json()
			#print(response)
			dumpjson = json.dumps(response)
			#dictjson = json.loads(dumpjson)	
			setcounter+=1

			try:
				if(response.get('additional_info').get('exiftool').get('FileType')=='Win32 EXE'):
					print("Yes! Windows!!")
					with open(os.path.join(hashes_path, winhash_name), "a") as winhash:
						winhash.write(item)
						winhash.write("\n")
						winhash.flush()
					with open(os.path.join(responses_path, responses_name), "a") as windows_response:
						windows_response.write(dumpjson)
						windows_response.write("\n")
						windows_response.flush()

			except:
				continue




	else:
		for item in lines:
			time.sleep(0.1)
			print('Checking item...',counter,"...", item)
			resource = item
			params = {'apikey': apikey, 'resource': resource, 'allinfo': 1}
			response = requests.get(url, params=params).json()
			#print(response)
			dumpjson = json.dumps(response)
			#dictjson = json.loads(dumpjson)	
			counter+=1

			try:
				if(response.get('additional_info').get('exiftool').get('FileType')=='Win32 EXE'):
					print("Yes! Windows!!")
					with open(os.path.join(hashes_path, winhash_name), "a") as winhash:
						winhash.write(item)
						winhash.write("\n")
						winhash.flush()
					with open(os.path.join(responses_path, responses_name), "a") as windows_response:
						windows_response.write(dumpjson)
						windows_response.write("\n")
						windows_response.flush()

			except:
				continue




def createFolder(directory):
    try:
        if not os.path.exists(directory):
            os.makedirs(directory)
    except OSError:
        print ('Error: Creating directory. ' +  directory)




def filename(): 

	raw_malware_hashes = './Raw_Malware_Hashes'
	for i in range(307, 357):
		raw_malware_name = "virushashes_%d.txt"%i
		with open(os.path.join(raw_malware_hashes, raw_malware_name), "r") as f:
			lines = [line.rstrip('\n') for line in f]
			receiveresource(lines, i)
			



def insertintofile():
	print('Heyy')

	raw_malware_hashes = './Raw_Malware_Hashes'
	mkdir_p(raw_malware_hashes)
	
	for i in range(306, 357):
		url = "https://virusshare.com/hashes/VirusShare_{0}.md5".format(str(i).zfill(5))
		print("Attemping to download " + url + "...")

		raw_malware_name = "virushashes_%d.txt"%i

		with open(os.path.join(raw_malware_hashes, raw_malware_name), "a") as f:
			try:
				# Try to download the file
				with urlopen(url) as resp:
				# Write the response to the file
					f.write("\n".join(str(resp.read()).strip("b'").split("\\n")[6:]))
					print("Successfully saved " + url)

			except HTTPError as e:
	            # Check if a 404 was received
				if e.code == 404:
					print(url + " returned a 404.")
					print("Hashes file creation complete.")
					exit(0)


	

if __name__== "__main__":
	try:
	    create_connection(("www.google.com", 443))
	    print("Internet connection established!")
	except OSError:
	    print("Please connect to the internet!")
	    exit(1)


	#insertintofile()
	createFolder('./testfolder/')
	filename()




# curl 'https://virusshare.com/hashes/VirusShare_00306.md5' -H 'Connection: keep-alive' -H 'Cache-Control: max-age=0' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.109 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Referer: https://virusshare.com/hashes.4n6' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-GB,en-US;q=0.9,en;q=0.8' -H 'Cookie: SID=45qbih769t5ljjk2a0edruvja3' -H 'If-None-Match: "2246a1f-2100c6-5682adc361400"' -H 'If-Modified-Since: Sat, 24 Mar 2018 16:16:16 GMT' --compressed


