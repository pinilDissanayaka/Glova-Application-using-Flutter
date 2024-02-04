import os
from langchain.prompts import PromptTemplate 
import google.generativeai as genai


class ImageClassification(object):
    def __init__(self, skinType) -> None:
        os.environ['GOOGLE_API_KEY']= r"AIzaSyCh9p37Fug6BFuat7MCchPkp3HqK02txSY" #API KEY
        genai.configure(api_key=os.environ['GOOGLE_API_KEY'])
        self._model = genai.GenerativeModel('gemini-pro')
        
        self._skinType=skinType
        self._prompt=skinType 
        
    def geminiResponce(self) -> str:
        try:
            self._responce=self._model.generate_content(self._prompt, stream=True)
            for chunk in self._responce:
                self._responce_ = ''.join(chunk.text) 
            
            self._responce_ = self._responce_.replace("*", " ")

            return self._responce_
        except:
            return False
            

        
            
        

    







