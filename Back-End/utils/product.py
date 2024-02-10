import os
from dotenv import load_dotenv
from pymongo import MongoClient

load_dotenv(".env")


class Product(object):
    @classmethod
    def connectDB(cls, databaseName = 'Glova', collectionName='Products'):
        try:
            client=MongoClient(os.getenv('MONGO_CLIENT'))
            db=client[databaseName]
            collection=db[collectionName]
            connectionStatus=True
        except:
            print("Database connection failed!")
            connectionStatus=False

        return client, collection, connectionStatus
    
    
    def filterProducts(self):
        pass