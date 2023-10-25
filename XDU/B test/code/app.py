from flask import Flask
from flask import render_template
from gevent.pywsgi import WSGIServer

app = Flask(__name__)

@app.route('/')
def info_handler():
    return render_template('index.html')

if __name__ == '__main__':
    # from waitress import serve
    # serve(app, host="127.0.0.1", port=5000)
    app.run()
    # http_server = WSGIServer(('', 4000), app)
    # http_server.serve_forever()

