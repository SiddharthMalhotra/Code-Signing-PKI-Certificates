import os
from OpenSSL import crypto
import asn1


def get_next_element(my_itr):
    try:
        return my_itr.next()
    except StopIteration:
        return None


def main():
    #f=open("/Users/siddharth/Downloads/VirusShare_39e344cd04ac5b9b6dc82ee4025f209a.txt", "r")

    #alist = [line.strip() for line in open('/Users/siddharth/Downloads/VirusShare_39e344cd04ac5b9b6dc82ee4025f209a.txt')]

    list1 = []

    path = '/home/ubuntu/MyVolumeStore/certs/315/'
    arr = os.listdir(path)
    #item = 'VirusShare_39e344cd04ac5b9b6dc82ee4025f209a.txt'

    for item in arr:
        print(item)
        total_path = path + item
        print (total_path)

        alist = [line.strip() for line in open(total_path)]

        print(type(alist))

        blist = enumerate(alist)
        print(blist)

        count = 0
        notfound = 0

        for i in range(count):
            dict[i] = ""

        list_begin = []
        list_endcert = []

        for k,v in blist:
            if v == "-----BEGIN CERTIFICATE-----":
                list_begin.append(k)
            elif v=="-----END CERTIFICATE-----":
                list_endcert.append(k+1)

        print(list_begin)
        print(list_endcert)

        total_len = len(list_begin)

        newpath = '/home/ubuntu/MyVolumeStore/certs/extract_315/'

        new_cert_length = newpath + '/' + 'total_len.txt'
        print(new_cert_length)
        with open(new_cert_length,"a+") as tl:
            tl.write(str(total_len))
            tl.write('\n')
        #print(total_len)

        country = newpath + '/' + 'country.txt'
        organisation = newpath + '/' + 'organisation.txt'
        crl = newpath + '/' + 'crl.txt'


        if(total_len>0):
            for i in range(total_len):
                #newpath = path + '_' + str(i + 1)
                for line in range(list_begin[i],list_endcert[i]):
                    print (alist[line])
                    new_cert = newpath + '/' + item[:-4] + '_' + str(i + 1)+ '.pem'
                    print(new_cert)
                    with open (new_cert, "a+") as cert_file:
                        cert_file.write(alist[line])
                        cert_file.write('\n')

                cert = crypto.load_certificate(crypto.FILETYPE_PEM, open(new_cert).read())

                subject = cert.get_subject()
                print(subject.C)
                with open(country, "a+") as c:
                    c.write(str(subject.C))
                    c.write('\n')
                with open(organisation, "a+") as org:
                    org.write(str(subject.O))
                    org.write('\n')
                #print(cert.get_pubkey())



                count = cert.get_extension_count()
                print(count)
                for number in range(count):
                    ext = cert.get_extension(number)
                    #print(ext.get_short_name())
                    if (ext.get_short_name().decode("utf-8")  == 'crlDistributionPoints'):
                        str1 = cert.get_extension(number)
                        str2 = str(str1).strip()
                        str3 = "".join(str2.split())


                        result = str3.find('http:')
                        print(str3[result:])
                        with open(crl, "a+") as crlw:
                            crlw.write(str3[result:])
                            crlw.write('\n')
                    else:
                        notfound += 1


if __name__ == "__main__":
    main()