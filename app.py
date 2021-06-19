from flask import Flask, jsonify
import socket

app = Flask(__name__)
 
import urllib.request

external_ip = urllib.request.urlopen('https://ident.me').read().decode('utf8')


@app.route('/')
def index():
    return jsonify({'TASK': 'KOKO NETWORKS DEVOPS',
                    'node_name': socket.gethostname(),
                    'node_ip': socket.gethostbyname(socket.gethostname()),
                    'external_ip': external_ip,
                    })


if __name__ == '__main__':
    app.run(debug=True)
