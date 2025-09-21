import os
from mcp_grinder_server import pass_mod
from mcp_grinder_server import source_mod

def main():
    print("Hello from mcp-grinder-server!")
    

def sum(a, b):
    return a + b

def bad():
    s = source_mod.getSensitiveData()
    pass_mod.passThrough(s)