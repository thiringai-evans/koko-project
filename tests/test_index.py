import json
import socket
import urllib.request

external_ip = urllib.request.urlopen('https://ident.me').read().decode('utf8')

def test_index(app, client):
    res = client.get('/')
    assert res.status_code == 200
    expected = {'TASK': 'KOKO NETWORKS DEVOPS',
                'node_name': socket.gethostname(),
                'node_ip': socket.gethostbyname(socket.gethostname()),
                'external_ip': external_ip,
                }
    assert expected == json.loads(res.get_data(as_text=True))
