from flask import Flask
import time
# from gevent import monkey

# monkey.patch_all()

app = Flask(__name__)

@app.route('/')
@app.route('/index')
def index():
    return "Hello, World!"

@app.route('/cputask')
def cputask():
    for i in range(10000000):
        n = i*i*i
    return "CPU Task Completed"

@app.route('/iotask')
def iotask():
    time.sleep(2)
    return "IO Task completed"


if __name__ == '__main__':
    app.run(port=5000, debug=True)