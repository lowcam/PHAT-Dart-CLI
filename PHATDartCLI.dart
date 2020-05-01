/*
#-------------------------------------------------------------------------------
# PHAT  - Password Hashing Algorithm Tool
# CLI Dart Version
# v 0.1
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
# 
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
*/

import 'dart:io';

String printLicense() {

	print ('''
	PHAT Copyright (C) 2020 Lorne Cammack
	This program comes with ABSOLUTELY NO WARRANTY;
	This is free software, and you are welcome to redistribute it
	under certain conditions. See https://www.gnu.org/licenses/ for more details.
	''');

}

String inputText() {

	print ('Input Text: ');
	String inText = stdin.readLineSync();
	return inText;

}

main() {
  printLicense();
  String inpText = inputText();
  print (inpText);
}