from flask import Flask, request, jsonify
import gen

app=Flask(__name__)

@app.route("/sign-in", methods=['GET', 'POST'])
def signIn():
    return "signIn"


@app.route("/sign-up", methods=['GET', 'POST'])
def signUp():
    return "signup"


@app.route("/data", methods=['GET', 'POST'])
def data():
    return "data"


@app.route('/solution', methods=['GET', 'POST'])
def solution():
    ai=gen.ImageClassification("hi")
    responce = ai.fetchFromGen()
    if responce:
        return responce
    else:
        return "OOPS.. Something Went Wrong"

if __name__=="__main__":
    app.run(debug=True)