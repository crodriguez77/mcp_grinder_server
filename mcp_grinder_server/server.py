import os
from mcp_grinder_server import pass_mod
from mcp_grinder_server import source_mod

def main():
    print("Hello from mcp-grinder-server!")
    s = source_mod.customSource()
    pass_mod.passThrough(s)

def sum(a, b):
    return a + b