import sink_mod

def passThrough(p):
    passThrough1(p)

def passThrough1(p):
    sink_mod.writeToExternalStorage(p)