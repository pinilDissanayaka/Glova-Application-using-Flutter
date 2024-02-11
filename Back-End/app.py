import os
from dotenv import load_dotenv
from flask import Flask, request, jsonify, session
from flask_cors import CORS
import werkzeug
from utils.data import ConvertData
from utils.user import User
from utils.product import Product
import utils.gen as gen

load_dotenv(".env")

#App configurations
app=Flask(__name__)
CORS(app, origins=os.getenv('APP_ORIGINS'))
app.secret_key = os.getenv('APP_SECRECT_KEY')
user=User(app=app)



@app.route("/sign-in", methods=['GET', 'POST'])
def signIn():
    emailAddress = str(request.args['emailAddress'])
    password = str(request.args['password'])
    
    status, user_=user.logInUser(emailAddress=emailAddress, password=password)
    
    if not status:
        responce={"status": status, 'username': user_['username']}
    else:
        responce={"status": status, 'username': None}
        
    return jsonify({"responce":responce})


@app.route("/sign-up", methods=['GET', 'POST'])
def signUp():
    username = str(request.args['username'])
    emailAddress = str(request.args['emailAddress'])
    phoneNumber = str(request.args['phoneNumber'])
    password = str(request.args['password'])
        
    status=user.addUser(username=username, emailAddress=emailAddress, phoneNumber=phoneNumber, password=password)
    
    if status:
        session['loggedIn'] = True
        session['emailAddress'] = emailAddress
        session['username']=username
        
        responce={"status": "success", 'username': username}
        
    else:
        responce={"status": "unsuccess", 'username': None}

    return jsonify({"responce" : responce})


@app.route("/logout", methods = ['GET', 'POST'])
def logout():
    
    session.pop('loggedIn', None)
    session.pop('emailAddress', None)
    session.pop('username', None)
    
    return jsonify({"status": "success"})
    

@app.route("/update", methods = ['GET', 'POST'])
def update():
    
    if session['loggedIn']:
        
        username = str(request.args['username'])
        emailAddressEdited = str(request.args['emailAddress'])
        emailAddress=session['emailAddress']
        phoneNumber = str(request.args['phoneNumber'])
        gender = str(request.args['gender'])
        address = str(request.args['address'])
                
        
        if not username is None:
            status=user.updateUser(emailAddress=emailAddress, username=username)  
            session['username']=username
        if not emailAddress is None:
            status=user.updateUser(emailAddress=emailAddress, emailAddressEdited=emailAddressEdited)
            session['emailAddress'] = emailAddress
        if not phoneNumber is None:
            status=user.updateUser(emailAddress=emailAddress, phoneNumber=phoneNumber)
        if not gender is None:
            status=user.updateUser(emailAddress=emailAddress, gender=gender)
        if not address is None:
            status=user.updateUser(emailAddress=emailAddress, address=address)
            
    
        responce={"status" : status, "username" : session['username']}
    else:
        responce={"status" : status, "username" : None}
            
    
    return jsonify({"responce": responce})

@app.route("/delete-user", methos=['GET', 'POST'])
def deleteUser():
    emailAddress=session['emailAddress']
    status=user.deleteUser(emailAddress=emailAddress)
    
    session.pop('loggedIn', None)
    session.pop('emailAddress', None)
    session.pop('username', None)
    
    if status:
        responce={"status": "success"}
    else:
        responce={"status": "unsuccess"}
    
    return jsonify({"responce": responce})
        
        
        
        
@app.route("/skin-data", methods=['GET', 'POST'])
def skinData():
    if session['loggedIn']:
        skinTypeNo = int(request.args['skinType'])
        skinToneNo = int(request.args['skinTone'])
        emailAddress=session['emailAddress']
        
        skinConcernNoList = list(request.args['skinConcern'])

        convertData = ConvertData()
        skinType, skinTone, skinConcernList = convertData.convertSkinData(skinTypeNo=skinTypeNo, skinToneNo=skinToneNo, skinConcernNoList=skinConcernNoList)
        
        
        status=user.updateUser(emailAddress=emailAddress, skinType=skinType, skinTone=skinTone, skinConcernList=skinConcernList)

        if status:
            responce={"status": "success"}
        else:
            responce={"status": "unsuccess"}
    else:
        responce={"status": "unsuccess"}
        
    return jsonify({"responce": responce})
    
    


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
        
    
        _, user_ = user.getUserByEmail(emailAddress=emailAddress)
        
        ai=gen.Solution(skinType=user_['skinType'], skinTone=user_['skinTone'])
        responce = ai.geminiResponce(imagePath=saveDir)
    
    if responce:
        return jsonify({"status": "success", 'prompt': responce})
    else:
        return jsonify({"status": "unsuccess", 'prompt': None})



if __name__=="__main__":
    app.run(debug=True, port=5000)