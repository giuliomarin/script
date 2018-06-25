# Giulio Marin
#
# giulio.marin@me.com
# 2016/07/01

import os
import shutil

def orderfolders(folder):
    alldirs = [os.path.join(folder, d) for d in os.listdir(folder) if os.path.isdir(os.path.join(folder, d))]
    alldirs.sort(key = lambda f: os.path.getmtime(f), reverse = True)
    return alldirs

def deleteallbutlatestmodified(folder):
    alldirs = [os.path.join(folder, d) for d in os.listdir(folder) if os.path.isdir(os.path.join(folder, d))]

    # do not delete if there is only one directory
    if len(alldirs) == 1:
        print 'Only one directory left in %s' % folder
    else:
        latestmodified = getlatestmodifieddir(folder)
        for d in alldirs:
            if d == latestmodified:
                continue
            else:
                print 'Removing: %s' % d
                shutil.rmtree(d)

def getlatestmodifieddir(folder):
    alldirs = [os.path.join(folder, d) for d in os.listdir(folder) if os.path.isdir(os.path.join(folder, d))]
    latestmodifieddir = max(alldirs, key = os.path.getmtime)
    return latestmodifieddir

if __name__ == '__main__':

    # iOS DeviceSupport
    deleteallbutlatestmodified(os.path.expanduser('~/Library/Developer/Xcode/iOS DeviceSupport'))
    deleteallbutlatestmodified(os.path.expanduser('~/Library/Developer/Xcode/watchOS DeviceSupport'))
    #deleteallbutlatestmodified(os.path.expanduser('~/Library/Developer/Xcode/iOS Device Logs'))

