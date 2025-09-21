def writeToExternalStorage(data):
    with open("external_storage.txt", "w") as f:
        f.write(data)