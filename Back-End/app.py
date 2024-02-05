from flask import Flask, request, jsonify, session
from  flask_mysqldb import MySQL
import MySQLdb.cursors
import gen

app=Flask(__name__)

#MySQl configurations
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'Glova'

mysql = MySQL(app)


@app.route("/sign-in", methods=['GET', 'POST'])
def signIn():
    return "signIn"


@app.route("/sign-up", methods=['GET', 'POST'])
def signUp():
    return "signup"


@app.route("/data", methods=['GET', 'POST'])
def data():
    return "data"

@app.route("/chat-bot", methods=['GET', 'POST'])
def chatBot():
    return "chat-bot"


@app.route('/solution', methods=['GET', 'POST'])
def solution():
    ai=gen.Solution("oily skin")
    responce = ai.geminiResponce()
    if responce:
        return jsonify({'response' : responce})
    else:
        return jsonify({'responce' : False})

if __name__=="__main__":
    app.run(debug=True)