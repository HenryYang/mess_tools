#!/usr/bin/env python3

import requests
from lxml import html
from bs4 import BeautifulSoup


def get_pages():
    r = requests.get('https://unity3d.com/unity/qa/lts-releases')
    tree = html.fromstring(r.text)
    pages = tree.xpath('//*[@id="main-wrapper"]/div[4]/div/div[2]/div[21]/div/ul/text()')

    return (len(pages))

def download_torrent(max_pages):
    for i in range(1, max_pages):
        r = requests.get('https://unity3d.com/unity/qa/lts-releases?page='+str(i))
        soup = BeautifulSoup(r.text, 'html.parser')
        for torrent_url in soup.find_all('a',{'class':'cn download-register', 'data-download-register-os':'Mac'}):
            if '.torrent' in torrent_url['href']:
                torrent_name = torrent_url['href'].split('/')                
                torrent_file = requests.get(torrent_url['href'])
                open(torrent_name[-1], 'wb').write(torrent_file.content)
                print(torrent_name[-1] + ' Downloaded!')

if __name__ == '__main__':
    max_pages = get_pages()
    download_torrent(max_pages)