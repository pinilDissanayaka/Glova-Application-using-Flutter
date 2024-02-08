import os
import PIL
from flask import Flask, request, jsonify, session
from flask_bcrypt import Bcrypt
import werkzeug
from pymongo import MongoClient
import gen

app=Flask(__name__)
app.secret_key = "123456789"
bcrypt = Bcrypt(app)

#DB configurations
client = MongoClient('mongodb://localhost:27017')
db = client['Glova']


@app.route("/sign-in", methods=['GET', 'POST'])
def signIn():
    
    emailAddress = str(request.args['emailAddress'])
    password = str(request.args['password'])
    collection = db['Users']
    
    user = collection.find_one({"emailAddress" : emailAddress})
    
    if (user == None):
        responce = False
    else:
        isValid = bcrypt.check_password_hash(user['password'], password)
        
        if(isValid):
            responce = user['username']
            
            session['loggedIn'] = True
            session['userId'] = user['_id']
            session['username'] = user['username']
            
        else:
            responce = False
    return jsonify({'responce' : responce})


@app.route("/sign-up", methods=['GET', 'POST'])
def signUp():
    username = str(request.args['username'])
    emailAddress = str(request.args['emailAddress'])
    phoneNumber = str(request.args['phoneNumber'])
    password = str(request.args['password'])
        
    collection = db['Users']
    
    ifExsist = collection.find_one({"emailAddress" : emailAddress})
    
    if (ifExsist == None):
        password = bcrypt.generate_password_hash(password).decode('utf-8')
        collection.insert_one({"username" : username, "emailAddress" : emailAddress, "phoneNumber" : phoneNumber, "password" : password})
        responce = True
    else:
        responce = False

    return jsonify({'responce': responce})

@app.route("/logout", methods = ['GET', 'POST'])
def logout():
    session.pop('loggedIn', None)
    session.pop('userId', None)
    session.pop('username', None)
    

@app.route("/update", methods = ['GET', 'POST'])
def update():
    
    if session['loggedIn'] == True:
        username = str(request.args['username'])
        emailAddress = str(request.args['emailAddress'])
        phoneNumber = str(request.args['phoneNumber'])
        gender = str(request.args['gender'])
        address = str(request.args['address'])
        
        collection = db['Users']
        collection.update_one({'_id' : session['userId']}, {'$set' : {'username' : username, 'emailAddress' : emailAddress, 'phoneNumber' : phoneNumber, 'gender' : gender, 'address' : address}})
        
        session['username'] = username
            
    
@app.route("/data", methods=['GET', 'POST'])
def data():
    skinType = str(request.args['skinType'])
    skinTone = str(request.args['skinTone'])
    skinConcern = list(request.args['skinConcern'])
    print(skinConcern)
    return "data"


@app.route("/chat-bot", methods=['GET', 'POST'])
def chatBot():
    return "chat-bot"


@app.route('/solution', methods=['GET', 'POST'])
def solution():
    
    imageFile=request.files['image']
    fileName=werkzeug.utils.secure_filename(imageFile.filename)
    saveDir=os.path.join("upload", fileName)
    imageFile.save(saveDir)
    
    ai=gen.Solution("oily skin")
    
    responce = ai.geminiResponce(imagePath=saveDir)
    
    if responce:
        return jsonify({'response' : responce})
    else:
        return jsonify({'responce' : False})


if __name__=="__main__":
    app.run(debug=True, port=5000)