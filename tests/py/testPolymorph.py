import swigex as mf

class ChildTwo(mf.ParentBase):
    def __init__(self):
        super(ChildTwo,self).__init__()
    
    def getHello(self):
        return "ChildTwo in Python - Hello"

pa = mf.ParentBase()
mf.showHello(pa)

co = mf.ChildOne()
mf.showHello(co)
    
ct = ChildTwo()
mf.showHello(ct)

