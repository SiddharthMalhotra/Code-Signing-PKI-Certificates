import json

# path = '/Users/siddharth/Downloads/responses_windows_virushashes_316.json'
#
# with open(path, 'r') as jsonfile:
#     for line in jsonfile:
#         dict = json.loads(line)
#         print(dict['md5'])


    #
    # for line in signedfile:
    #     print (line)


#path = ''
textfile = '/home/ubuntu/MyVolumeStore/textfile.txt'
with open('/home/ubuntu/MyVolumeStore/signedfile') as signedfile:
    for line in signedfile:
        for i in range(7,16):
            filenumber = 300 + i
            path = '/home/ubuntu/MyVolumeStore/Virustotal_Responses/responses_windows_virushashes_%d.json'%filenumber
            with open (path) as responsefile:
                for linejson in responsefile:
                    dict = json.loads(linejson)
                    if line == dict['md5']:
                        with open(textfile, 'w') as txte:
                            txte.write(linejson)
                            txte.flush()



