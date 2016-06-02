import os
import shutil

inFolder = "/Volumes/giulio/Desktop/sirapp_2016_02_04/Snapshot1/Frames"
filenameIn = "master_%d.png"
filenameOut = "%d.png"

outFolder = "/Users/giulio/Desktop/zoom"


# Create output foder
if not os.path.exists(outFolder):
    os.makedirs(outFolder)

for idx in range(1,52):
    filePathIn = (os.path.join(inFolder, filenameIn)) % idx
    filePathOut = (os.path.join(outFolder, filenameOut)) % idx
    if os.path.exists(filePathIn):
        print "%s -> %s\n" % (filePathIn, filePathOut)
        shutil.copyfile(filePathIn, filePathOut)
    else:
        print "File %s does not exist\n" % filePathIn