from pymongo import MongoClient
class User(object):
    @classmethod
    def connectDB(cls):
        client=MongoClient('mongodb://localhost:27017')
        try:
            db=client['Glova']
            cls.collection=db['Users']
            connectionStatus=True
        except:
            connectionStatus=False

        
        return cls.collection, connectionStatus
        
    def addUser(self, username, emailAddress, phoneNumber, password):
        collection, connectionStatus=User.connectDB()
        if connectionStatus in True:
            collection.insert_one({"username" : username, "emailAddress" : emailAddress, "phoneNumber" : phoneNumber, "password" : password})
        
        
            
        
        
    
    
    def getUser(self):
        pass
    
    
    @classmethod
    def checkUser(cls):
        cls.collection
        