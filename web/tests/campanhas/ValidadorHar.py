import json
from haralyzer import HarPage
import os

def validar_har(id, url):
#to do criar um parametro para ser passado como validador da url após filtro
    with open(r"D:\Users\igor.mendes\Documents\smb-robot-test\web\tests\campanhas\har\file.har", 'r') as f:
        har_page = HarPage(id, har_data=json.loads(f.read()))

    entries = har_page.filter_entries(request_type='POST', status_code='2.*', content_type='application/json')

    for i in range(0,len(entries)):
        if (entries[i].url == url):
            #print(entries[i].url)
            return True

def deletar_har():
    if os.path.exists(r"D:\Users\igor.mendes\Documents\smb-robot-test\web\tests\campanhas\har\file.har"):
        os.remove(r"D:\Users\igor.mendes\Documents\smb-robot-test\web\tests\campanhas\har\file.har")
    else:
        print("O arquivo não existe")