import os
import google.generativeai as genai
from langchain.prompts import PromptTemplate
import PIL


class Solution(object):
    def __init__(self, skinType : str) -> None:
        os.environ['GOOGLE_API_KEY']= r"AIzaSyBUd99N6xQQmy-233yhwEJnLXH_4oNRJzE" #API KEY
        genai.configure(api_key=os.environ['GOOGLE_API_KEY'])
        
        generation_config={
                        'temperature':0.01, 
                        'max_output_tokens': 300
                    }
        
        safety_settings=[
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
        
        self._model = genai.GenerativeModel('gemini-pro-vision')
        
        self._skinType=skinType
        self._prompt= "Identify this skin disease on this picture and assume that this skin disease on a {skinType} skin. please genarate a complete description about the disease, why this disease occurs and genarate that ways can be use to prevent and avoid this skin disease at descriptive manner."
        self._template = PromptTemplate(input_variables=['skinType'], 
                                        template=self._prompt)
          
                        
        
    def geminiResponce(self, imagePath : str) -> str:
        try:
            imageFile=PIL.Image.open(imagePath)
            self._response=self._model.generate_content([self._template.format(skinType=self._skinType), imageFile], stream=False)
                
            for chunk in self._response:
                self._response_ = ''.join(chunk.text) 
            
            #print(self._response_)
            return self._response_
        except:
            return False
            
            
            
        

    







