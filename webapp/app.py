from flask import Flask
from flask_wtf.csrf import CSRFProtect

app = Flask(__name__)
csrf = CSRFProtect()
csrf.init_app(app)


@app.route('/', methods=['GET'])
def hello():
    return 'Hello world!'


if __name__ == '__main__':
    app.run(host='0.0.0.0')
