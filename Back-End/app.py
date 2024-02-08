import os
from flask import Flask, request, jsonify, session
from flask_cors import CORS
from flask_bcrypt import Bcrypt
import werkzeug
from pymongo import MongoClient
import bson
from data import ConvertData
import gen

app=Flask(__name__)
CORS(app, origins='http://localhost:62458')
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
    
    if user is None:
        responce=False
    else:
        isValid = bcrypt.check_password_hash(user['password'], password)
        
        if(isValid):
    
            session['loggedIn'] = True
            session['emailAddress'] = emailAddress
            session['username'] = user['username']
            
            responce=user['username'] 
        
        else:
            responce=False
        
    return jsonify({"responce":responce})


@app.route("/sign-up", methods=['GET', 'POST'])
def signUp():
    username = str(request.args['username'])
    emailAddress = str(request.args['emailAddress'])
    phoneNumber = str(request.args['phoneNumber'])
    password = str(request.args['password'])
        
    collection = db['Users']
    
    ifExsist = collection.find_one({"emailAddress" : emailAddress})
    
    if ifExsist is None:
        password = bcrypt.generate_password_hash(password).decode('utf-8')
        
        collection.insert_one({"username" : username, "emailAddress" : emailAddress, "phoneNumber" : phoneNumber, "password" : password})
            
        session['loggedIn'] = True
        session['emailAddress'] = emailAddress
        session['username']=username
        responce = username
        
    else:
        responce=False

    return jsonify({"responce" : responce})


@app.route("/logout", methods = ['GET', 'POST'])
def logout():
    
    session.pop('loggedIn', None)
    session.pop('emailAddress', None)
    session.pop('username', None)
    
    return jsonify({'response' : True})
    

@app.route("/update", methods = ['GET', 'POST'])
def update():
    
    if session['loggedIn'] is True:
        
        username = str(request.args['username'])
        emailAddress = str(request.args['emailAddress'])
        phoneNumber = str(request.args['phoneNumber'])
        gender = str(request.args['gender'])
        address = str(request.args['address'])
        
        collection = db['Users']
        
        collection.update_one({'emailAddress' : session['emailAddress']}, {'$set' : {'username' : "username", 'emailAddress' : emailAddress, 'phoneNumber' : phoneNumber, 'gender' : gender, 'address' : address}})
        
        session['username'] = username
        session['emailAddress'] = emailAddress
        
        
@app.route("/skin-data", methods=['GET', 'POST'])
def skinData():
    skinTypeNo = int(request.args['skinType'])
    skinToneNo = int(request.args['skinTone'])
    skinConcernNoList = list(request.args['skinConcern'])

    convertData = ConvertData()
    skinType, skinTone, skinConcernList = convertData.convertSkinData(skinTypeNo=skinTypeNo, skinToneNo=skinToneNo, skinConcernNoList=skinConcernNoList)
    
    collection=db['Users']


    collection.update_one({'emailAddress' : session['emailAddress']}, {'$set' : {'skinType' : skinType, 'skinTone' : skinTone, 'skinConcernList' : skinConcernList}})
    
    return jsonify({'response' : True})


'''
@app.route("/get-category", methods=['GET', 'POST'])
def getCategory():

    categoryNoList = list(request.args['categoryNo'])

    convertData = ConvertData()
    categoryList = convertData.convertSkinData(categoryNoList=categoryNoList)
    
    collection=db['Users']
    collection.update_one({'emailAddress' : collection['_id']}, {'$set' : {'skinType' : skinType, 'skinTone' : skinTone, 'skinConcernList' : skinConcernList}})
    
    return jsonify({'response' : True})
'''


@app.route("/chat-bot", methods=['GET', 'POST'])
def chatBot():
    return "chat-bot"


@app.route('/solution', methods=['GET', 'POST'])
def solution():
    if session['loggedIn']:
        imageFile=request.files['image']
        fileName=werkzeug.utils.secure_filename(imageFile.filename)
        saveDir=os.path.join("upload", fileName)
        imageFile.save(saveDir)
        
        emailAddress = session['emailAddress']
        
        collection = db['Users']
        user = collection.find_one({"emailAddress" : emailAddress})
        
        ai=gen.Solution(skinType=user['skinType'], skinTone=user['skinTone'])
        responce = ai.geminiResponce(imagePath=saveDir)
    
    if responce:
        return jsonify({'response' : responce})
    else:
        return jsonify({'responce' : False})


if __name__=="__main__":
    app.run(debug=True, port=5000)