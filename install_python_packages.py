##################################
#
# On Mac OS install Python using brew install Python
# (The version already installed is not good for development)
#
##################################

import subprocess
import shutil
import sys
import os

def install_package(package):
    print '\n--- Installing ' + package + ' ---\n'
    if sys.platform == "win32":
        subprocess.call(['pip', 'install', package])
    elif sys.platform == "darwin": #OSX
        subprocess.call(['pip', 'install', package])

def install_package_easy(package):
    print '\n--- Installing ' + package + ' ---\n'
    if sys.platform == "win32":
        subprocess.call(['easy_install', package])
    elif sys.platform == "darwin": #OSX
        subprocess.call(['easy_install', package])

def install_package_brew(package):
    print '\n--- Installing ' + package + ' ---\n'
    if sys.platform == "win32":
        print "Not implemented."
    elif sys.platform == "darwin": #OSX
        subprocess.call(['brew', 'install', package])

install_package_easy('pip')
subprocess.call(['pip', 'install', '--upgrade', 'pip'])
install_package('numpy')
install_package('scipy')
install_package('pillow')
install_package('pyaml')
install_package('xlwt')
install_package('pymysql')
install_package('matplotlib')
install_package('pyserial')
install_package_brew('mysql')
install_package('pymysql')
install_package('clipboard')
install_package('xlsxwriter')
install_package('dropbox')
install_package('jupyter')
install_package('mpld3')
install_package('pandoc')
install_package('moviepy')
