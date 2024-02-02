import os
import google.generativeai as genai


class ImageClassification(object):
    def __init__(self, skinType) -> None:
        os.environ['GOOGLE_API_KEY']= r"AIzaSyCh9p37Fug6BFuat7MCchPkp3HqK02txSY" #API KEY
        genai.configure(api_key=os.environ['GOOGLE_API_KEY'])
        self._model = genai.GenerativeModel('gemini-pro')
        
        self._skinType=skinType
        self._prompt=skinType 
        
    def fetchFromGen(self) -> str:
        try:
            self._responce=self._model.generate_content(self._prompt, stream=True)
            for chunk in self._responce:
                self._text = ''.join(chunk.text) 
            
            self._text = self._text.replace("*", " ")

            return self._text
        except:
            return False
            

        
            
        

    







