class ConvertData(object):
    def __init__(self) -> None:
        self._skinTypes = ["Dry", "Oily", "AGNE", "Combination", "Normal", "Sensitive"]
        self._skinTones = ["Light", "Medium", "Dark", "Medium Light", "Medium Dark"]
        self._skinConcerns = ["Acne Scars", "Black/White Heads", "Dark Undereyes", "Duliness", "Hyper-Pigmentation", "Roughness", "Large Pores", "Sensitivity", "Wrinkles"]

    
    def convertSkinData(self, skinTypeNo : int, skinToneNo : int, skinConcernNoList : list):
        skinType = self._skinTypes[skinTypeNo]
        skinTone = self._skinTones[skinToneNo]
        skinConcernList = list()
        for concernNo in skinConcernNoList:
            concernNo=int(concernNo)
            skinConcernList.append(self._skinConcerns[concernNo])
        
        return skinType, skinTone, skinConcernList
    
    #def convertCategory(self, categoryNoList : list):
        #categoryList=list()
        #for categoryNo in categoryNoList:
            #int(categoryNo)
            #categoryList.append(self._)
        
        
    
    