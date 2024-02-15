import os
from dotenv import load_dotenv
from pymongo import MongoClient

load_dotenv(".env")


class Professional(object):
    @classmethod
    def connectDB(cls, databaseName = 'Glova', collectionName='Professionals'):
        try:
            client=MongoClient(os.getenv('MONGO_CLIENT'))
            db=client[databaseName]
            collection=db[collectionName]
            connectionStatus=True
        except:
            print("Database connection failed!")
            connectionStatus=False

        return client, collection, connectionStatus
    
    
    def filterProfessional(self, style='ranking'):
        pass