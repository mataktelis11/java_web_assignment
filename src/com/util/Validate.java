package com.util;

public class Validate {
	
	public static boolean validPass(String pass) {
		// Requirements: minimum 1 lower-case character, 1 upper-case character, 1 digit and minimum length 8
		
		// If length < 8 return false
		if(pass.length() < 8) return false;
		// If no lower case return false
		if(pass.toUpperCase().equals(pass)) return false;
		// If no upper case return false
		if(pass.toLowerCase().equals(pass)) return false;
		// If there is at least one digit return true, otherwise return false
		for(int i = 0; i < pass.length(); i++) {
			if(Character.isDigit(pass.charAt(i))) return true;
		}
		return false;
	};
	
	public static boolean validAMKA(String amka) {
		// Requirements: minimum length 11
		if(amka.length() < 11) return false;
		else return true;
	};
	
}
