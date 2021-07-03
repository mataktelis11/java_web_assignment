package com.model;



/**
 * 
 * This is the class of the Administrators of the web application and a child of the User class.
 * 
 * @authors telis, vasilis, atnwnis
 * 
 */
public class Admin extends User {
	
	/**
	 * Constructor of the Admin Class.
	 * 
	 * @param username	The username of the Administrator
	 * @param password	The password of the Administrator
	 * @param name		The name of the Administrator
	 * @param surname	The surname of the Administrator
	 * 
	 */
	
	private String headAdmin;
	
	public Admin(String username, String password, String name, String surname) {
		super(username, password, name, surname);
	}

	public Admin() {
		super();
	}

	public String getHeadAdmin() {
		return headAdmin;
	}

	public void setHeadAdmin(String headAdmin) {
		this.headAdmin = headAdmin;
	}
	
	
}

