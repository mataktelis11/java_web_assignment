package com.model;


/**
 * 
 * This is the class of the Head Administrators of the web application and a child of the Admin class. It has no children so it is <b>final</b>.
 * 
 * @authors telis, vasilis, atnwnis
 * 
 */
public final class HeadAdmin extends Admin{

	public HeadAdmin(String username, String password, String name, String surname) {
		super(username, password, name, surname);
		
	}
}
