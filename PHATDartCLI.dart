/*
#-------------------------------------------------------------------------------
# PHAT  - Password Hashing Algorithm Tool
# CLI Dart Version
# v 2.0.1
#
# The purpose of this tool is to let an individual enter text and have a hashed
# output to use as the password to the site or program. Initially the program
# will hash the input in SHA 256 and output in hexadecimal. The plans for this
# program are to allow the selection of three different SHA lengths (256, 384,
# and 512). Also, the output numbering system will be selectable between
# hexadecimal, base64, and base58. Also, the number of digits in the ouput
# will be selectable in case a site can only have a certain number of digits
# in a password. The last step will be for the output to be copied to the
# clipboard so if can be pasted into the program or site.
#
# Update 2.0.1 updated DART to >= 3.5.3 and updated dependencies 
# as of October of 2024. Code updated to comply with the updates.
#
# *****Make sure to run flutter clean and then flutter pub get
#      to update the dependencies before trying to run the dart file*****
#
# (C) 2024 Lorne Cammack, USA
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
*/

import 'dart:io';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:fast_base58/fast_base58.dart';


String printLicense() {

	print ('''
	PHAT Copyright (C) 2024 Lorne Cammack
	This program comes with ABSOLUTELY NO WARRANTY;
	This is free software, and you are welcome to redistribute it
	under certain conditions. See https://www.gnu.org/licenses/ for more details.
	''');
	String returnText = 'return';
	return returnText;

}

String inputText() {

	print ('Input Text: ');
	String inText = stdin.readLineSync()!;
	return inText;

}

int shaSize() {

	print ('How Many Bits in SHA? (A: 256, B: 384 C: 512)');
	String shaIn = stdin.readLineSync()!;
	int counterSha = 0;
	int returnSha = 0;
	while (counterSha == 0){
		if (shaIn == 'A' || shaIn == 'a'){
			returnSha = 256;
			counterSha = 1;
		}
		else if (shaIn == 'B' || shaIn == 'b'){
			returnSha = 384;
			counterSha = 1;
		}
		else if (shaIn == 'C' || shaIn == 'c'){
			returnSha = 512;
			counterSha = 1;
		}
		else {
			print ('Incorrect value entered. Please try again.');
			print ('How Many Bits in SHA? (A: 256, B: 384 C: 512)');
			shaIn = stdin.readLineSync()!;			
		}
	}
	return returnSha;
}

String numberSystemSelection() {

	print ('What number system would you like the output in? (D: Hex, E: Base64 F: Base58)');
	String numSysIn = stdin.readLineSync()!;
	String numSysReturn = '';
	int counterNumSys = 0;
	while (counterNumSys == 0){
		if (numSysIn == 'D' || numSysIn == 'd'){
			numSysReturn = 'Hex';
			counterNumSys = 1;
		}
		else if (numSysIn == 'E' || numSysIn == 'e'){
			numSysReturn = 'Base64';
			counterNumSys = 1;
		}
		else if (numSysIn == 'F' || numSysIn == 'f'){
			numSysReturn = 'Base58';
			counterNumSys = 1;
		}
		else {
			print ('Incorrect value entered. Please try again.');
			print ('What number system would you like the output in? (D: Hex, E: Base64 F: Base58)');
			numSysIn = stdin.readLineSync()!;
		}
	}
	
	return numSysReturn;
}

int outputDigits(){

	print ('Would you like to restrict the number of output digits? (Y: Yes, N: No)');
		String outDigIn = stdin.readLineSync()!;
		int counterOutDig1 = 0;
		int returnDig1 = 0;
		while (counterOutDig1 == 0){
			if (outDigIn == 'N' || outDigIn == 'n'){
				returnDig1 = 0;
				counterOutDig1 = 1;
			}
			else if (outDigIn == 'Y' || outDigIn == 'y'){
				print ('How many digits would you like? (1-128) ');
				String restOutDig = stdin.readLineSync()!;
				int counterOutDig2 = 0;
					while (counterOutDig2 == 0) {
						try {
							var restOutDigInt = int.parse(restOutDig);
							if (restOutDigInt < 1 || restOutDigInt > 128){
								print('Incorrect value entered. Please try again.');
								print ('How many digits would you like? (1-128) ');
								restOutDig = stdin.readLineSync()!;
							}
							else {
								returnDig1 = restOutDigInt;
								counterOutDig2 = 1;
							}
							
						} on FormatException {
							print('Incorrect value entered. Please try again.');
							print ('How many digits would you like? (1-128) ');
							restOutDig = stdin.readLineSync()!;
						}
						
					
					}
				counterOutDig1 = 1;
			}
			else {
				print ('Incorrect value entered. Please try again.');
				print ('Would you like to restrict the number of output digits? (Y: Yes, N: No)');
				outDigIn = stdin.readLineSync()!;
			}
		}
		return returnDig1;

}

String hashInput(String userText, int userSha){
	var bytes = utf8.encode(userText);
	if (userSha == 256){
		var digest1 = sha256.convert(bytes);
		String digest1str = digest1.toString();
		return digest1str;
	}
	else if (userSha == 384){
		var digest2 = sha384.convert(bytes);
		String digest2str = digest2.toString();
		return digest2str;
	}
	else {
		var digest3 = sha512.convert(bytes);
		String digest3str = digest3.toString();
		return digest3str;
	}
	
}

String numberSystemConvert (String userNumSys, String convHashText){
	List<int> bytes = hex.decode(convHashText);
	if (userNumSys == 'Hex'){
		return convHashText;
	}
	else if (userNumSys == 'Base64'){
		String base64text = base64.encode(bytes);
		return base64text;
	}
	else{
		String base58text = Base58Encode(bytes);
		return base58text;
	}
}

String finalOutputText (String convertedText, int outputDigits){

	if (outputDigits == 0){
		return convertedText;
	}
	else{
		int stringLength = convertedText.length;
		if (stringLength <= outputDigits){
			return convertedText;
		}
		else{
			String newString = convertedText.substring(0,outputDigits);
			return newString;
		}
	}

}



main() {
  printLicense();
  String inpText = inputText();
  int shaNum = shaSize();
  String numSys = numberSystemSelection();
  int outDig = outputDigits();
  String hashText = hashInput(inpText,shaNum);
  String numSysConv = numberSystemConvert(numSys,hashText);
  String finalPrint = finalOutputText(numSysConv,outDig);
  print (finalPrint);
  
}
