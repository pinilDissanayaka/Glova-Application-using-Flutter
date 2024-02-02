from datetime import datetime
from routing import Routing


class Recommended(object):
    def __init__(self) -> None:
        self._routing = Routing
        self.route = self._routing.getRouting()
        
        
    def getRecommend(self):
        if(0 < datetime.now().hour and datetime.now().hour > 18):
            print("night")
        elif(5 < datetime.now().hour and datetime.now().hour <10):
            print("morning")
        else:
            print("after")
            
            
    def checkRecommend(self):
        pass
    
    
        
    



