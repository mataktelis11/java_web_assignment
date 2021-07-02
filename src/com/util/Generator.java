package com.util;

import java.util.Random;

/**
 * Class that has method that generate random string of given length
 * 
 * 
 * @author telis, vasilis, atnwnis
 *
 */
public class Generator {
	
	private final String alphanumeric = "abcdefghijklmnopqrstuvxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+=`~[]{};";
	
	Random random;

	public Generator() {
		super();
		random = new Random();
	}


	public String generate(int length) {
		
		StringBuilder sb = new StringBuilder();
		int choice = alphanumeric.length();
		
		for(int i=0; i<length;i++) {
			
			sb.append(alphanumeric.charAt(random.nextInt(choice)));
		}
		
		return sb.toString();
	}
}

