import os
import google.generativeai as genai


class Solution(object):
    def __init__(self, skinType : str) -> None:
        os.environ['GOOGLE_API_KEY']= r"AIzaSyBUd99N6xQQmy-233yhwEJnLXH_4oNRJzE" #API KEY
        genai.configure(api_key=os.environ['GOOGLE_API_KEY'])
        
        self._generation_config={
                        'temperature':0, 
                        'max_output_tokens': 300
                    }
        
        self._safety_settings=[
            {
                "category": "HARM_CATEGORY_DANGEROUS",
                "threshold": "BLOCK_NONE",
            },
            {
                "category": "HARM_CATEGORY_HARASSMENT",
                "threshold": "BLOCK_NONE",
            },
            {
                "category": "HARM_CATEGORY_HATE_SPEECH",
                "threshold": "BLOCK_NONE",
            },
            {
                "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
                "threshold": "BLOCK_NONE",
            },
            {
                "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
                "threshold": "BLOCK_NONE",
            },
        ]
        
        self._model = genai.GenerativeModel('gemini-pro')
        
        self._skinType=skinType
        self._prompt= f"Identify this skin disease as a blackheads and assume that this skin disease on a {self._skinType} skin. please genarate a complete description about the disease, why this disease occurs and genarate that ways can be use to prevent and avoid this skin disease at descriptive manner."
                        
                        
        
    def geminiResponce(self) -> str:
        try:
            self._response=self._model.generate_content(self._prompt, stream=False)
            for chunk in self._response:
               self._response_ = ''.join(chunk.text) 
            
            #print(self._response_)
            return self._response_
        except:
            return False
            
            
            
        

    







