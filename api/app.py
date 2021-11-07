import time

import redis
from flask import Flask, request

from werkzeug.utils import secure_filename


UPLOAD_FOLDER = '/test'
ALLOWED_EXTENSIONS = {'txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'}

app = Flask(__name__)
app.secret_key = "super secret key"
cache = redis.Redis(host='redis', port=6379)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

def get_hit_count():
    retries = 5
    while True:
        try:
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)

@app.route('/')
def hello():
    count = get_hit_count()
    return 'Hello World!! I have been seen {} times.\n'.format(count)

@app.route('/test1')
def hello2():
    return 'Hello World!! test1: GET \n'

@app.route('/test2/<string:name>')
def hello3(name):
    return 'Hello ' + name

#upload file
@app.route('/upload', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        file = request.files['the_file']
        file.save(f"./test/{secure_filename(file.filename)}")
        return "file saved"

    else:
        return "could not save file"
