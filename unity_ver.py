import requests
from bs4 import BeautifulSoup

for i in range(1,10):
    r = requests.get('https://unity3d.com/unity/qa/lts-releases?page='+str(i))
    soup = BeautifulSoup(r.text, 'html.parser')
    for ii in soup.find_all('a',{'class':'cn download-register', 'data-download-register-os':'Mac'}):
        if '.torrent' in ii['href']:
            print(ii['href'])
            x = ii['href'].split('/')
            print(x[-1])

            myfile = requests.get(ii['href'])
            open(x[-1], 'wb').write(myfile.content)

