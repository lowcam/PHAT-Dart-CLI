#-------------------------------------------------------------------------------
# PHAT  - Password Hashing Algorithm Tool
# CLI Python Version
# v 1.0
#
# The purpose of this tool is to let an individual enter text and have a hashed
# output to use as the password to the site or program. Initially the program
# will hash the input in SHA 256 and output in hexadecimal. THe plans for this
# program are to allow the selection of three different SHA lengths (256, 384,
# and 512). Also, the output numbering system will be selectable between
# hexadecimal, base64, and base58. Also, the number of digits in the ouput
# will be selectable in case a site can only have a certain number of digits
# in a password. THe last step will be for the output to be copied to the
# clipboard so if can be pasted into the program or site.
#
# Required to use:
# Python3
# Python3-tk
# Use pip3 to install base58
#
# (C) 2020 Lorne Cammack, USA
# email lowcam.socailvideo@gmail.com
# Released under GNU Public License (GPL) v3
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.
#-------------------------------------------------------------------------------


import codecs
import hashlib
import base58
from tkinter import Tk

#Print license at the beginning of the file
def printLicense():
    print ("")
    print ("PHAT Copyright (C) 2020 Lorne Cammack")
    print ("This program comes with ABSOLUTELY NO WARRANTY;")
    print ("This is free software, and you are welcome to redistribute it")
    print ("under certain conditions. See https://www.gnu.org/licenses/ for more details.")
    print ("")

# This section has the user choose between 3 SHA lengths: 256, 384, and 512
def selectSHA():
    i = 1
    while (i == 1):
        shainput = input ('What SHA value would you like? (256, 384, or 512) ')
        global valuesha
        try:
            testVal = int(shainput)
        except ValueError:
            print("Incorrect value entered. Please try again.")
            i=1
        else:
            valuesha = int(shainput)
            if valuesha == 256:
                i = 2
            elif valuesha == 384:
                i = 2
            elif valuesha == 512:
                i = 2
            else:
                print ("Incorrect value entered. Please try again.")
                i=1

# This section deals with selecting an output number system between
# Hexidecimal, Base 64, and Base 58.
def OutputNumberSystem():
    i=1
    while (i==1):
        numsysvalue = input ('Choose output number system: 1. Hex; 2. Base64; 3. Base58  ')
        global valuenumsys
        try:
            testVal = int(numsysvalue)
        except:
            print("Incorrect value entered. Please try again.")
            i=1
        else:
            valuenumsys = int(numsysvalue)
            if valuenumsys == 1:
                i = 2
            elif valuenumsys == 2:
                i = 2
            elif valuenumsys == 3:
                i = 2
            else:
                print ("Incorrect value entered. Please try again.")
                i=1

# This section lets a user decide how many digits they want in the final output
def numdigfinal():
    i = 1
    while (i == 1):
        global finaldig
        digfinalyn = input ('Would you like to restrict the number of digits in the output? (Y/N) ')
        if digfinalyn == 'Y' or digfinalyn == 'y':
            digfinal = input ('How many digits would you like? (1-128) ')
            try:
                val = int(digfinal)
            except:
                print("Incorrect value entered. Please try again.")
                i=1
            else:
                finaldig = int(digfinal)
                if finaldig < 1 or finaldig > 128:
                    print ("This value is not acceptable")
                    i=1
                else:
                    i=2
        elif digfinalyn == 'N' or digfinalyn == 'n':
            finaldig = 0
            i=2
        else:
            print ("That is an incorrect selection.")
            i = 1

# This section gets the values ready to print. For Base64 and Base58 it
# decodes the output from Hex, which it is in when it is sent, and then
# reencodes it into the numbering system choosen in OutputNumberSystem().
def outputPrint(hexhashvalue):
    global printreturn
    printreturn=0
    if valuenumsys == 1:
        printreturn = hexhashvalue
    elif valuenumsys == 2:
        printreturn = codecs.encode(codecs.decode(hexhashvalue, 'hex'), 'base64').decode()
# The base64 return was putting a line return at the 76 character mark, which
# when copying into a password did not help. This code rectifies that. Also
# had to add the rstrip() so that a new line wouldn't be added after
# concatenating the two parts.
        printreturnLen = len(printreturn)
        if printreturnLen > 76:
            printreturnSide1 = printreturn[:76]
            printreturnEndCalc = printreturnLen - 77
            printreturnSide2 = printreturn[-printreturnEndCalc:]
            printreturn = printreturnSide1 + printreturnSide2
            printreturn = printreturn.rstrip()
    else:
        printreturn = base58.b58encode(codecs.decode(hexhashvalue, 'hex'))

# This section gets everything ready for the output
def finalprint (hexhashvalue):

    lenhash = len(hexhashvalue)
    global copyreturn
    copyreturn = printreturn
    if finaldig == 0 or finaldig >= lenhash:
        if valuenumsys == 1:
            #printreturn = hexhashvalue
            print ("SHA", valuesha, "sum in hex: ")
            print (printreturn)
        elif valuenumsys == 2:
            #printreturn = codecs.encode(codecs.decode(hexhashvalue, 'hex'), 'base64').decode()
            print ("SHA", valuesha, "sum in base64: ")
            print (printreturn)
        else:
            #printreturn = base58.b58encode(codecs.decode(hexhashvalue, 'hex'))
            print ("SHA", valuesha, "sum in base58: ")
            print (printreturn)
    else:
        if valuenumsys == 1:
            #printreturn = hexhashvalue
            print ("SHA", valuesha, "sum in hex: ")
            print (printreturn[:finaldig])
            copyreturn = printreturn[:finaldig]
        elif valuenumsys == 2:
            #printreturn = codecs.encode(codecs.decode(hexhashvalue, 'hex'), 'base64').decode()
            print ("SHA", valuesha, "sum in base64: ")
            print (printreturn[:finaldig])
            copyreturn = printreturn[:finaldig]
        else:
            #printreturn = base58.b58encode(codecs.decode(hexhashvalue, 'hex'))
            print ("SHA", valuesha, "sum in base58: ")
            print (printreturn[:finaldig])
            copyreturn = printreturn[:finaldig]

printLicense()
selectSHA()
OutputNumberSystem()
numdigfinal()
# Input from user.
inputText = input ('Enter value: ')
# Take the input text and convert it into byte format.
hashText = bytes(inputText, "ascii")

# This next section hashes the hashText into the correct SHA type as selected
# above
outputText = 0
if valuesha == 256:
    outputText = hashlib.sha256 (hashText).hexdigest()
elif valuesha == 384:
    outputText = hashlib.sha384 (hashText).hexdigest()
else:
    outputText = hashlib.sha512 (hashText).hexdigest()

outputPrint(outputText)
finalprint(outputText)

# code to copy output to clipboard_clear
r = Tk()
r.withdraw()
r.clipboard_clear()
r.clipboard_append(copyreturn)
r.update()
r.destroy()

exitText = input ('Hash Copied to Clipboard. Paste before pressing a key to continue')
