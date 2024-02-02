import os
import google.generativeai as genai

class ImageClassification(object):
    def __init__(self, skinType) -> None:
        os.environ['GOOGLE_API_KEY']= r"xxx" #API KEY
        genai.configure(api_key=os.environ['GOOGLE_API_KEY'])
        self._model = genai.GenerativeModel('gemini-pro')
        
        self._skinType=skinType
        self._prompt="hi"
        
    def fetchFromGen(self) -> str:
        self._responce=self._model.generate_content(self._prompt, stream=True)
        
        return self._responce

        
            
        

    







