package com.model;


/**
 *
 * This is the mother class of all Users of the web application. It is an <b>abstract</b> class.
 * 
 * @authors telis, vasilis, atnwnis
 * 
 */
public class User {
	
	private String username;
	private String password;
	private String name;
	private String surname;
	private String role;
	private String salt;
	
	/**
	 * Constructor of the class User. Updates a counter with each creation of a User
	 * 
	 * @param username	the user's username. Can include any characters
	 * @param password	the user's password. Can include any characters
	 * @param name		the user's name. Can only include characters
	 * @param surname	the user's surname. Can only include characters
	 * 
	 */
	public User(String username, String password, String name, String surname) {
		super();
		this.username = username;
		this.password = password;
		this.name = name;
		this.surname = surname;
	}
	
	public User(String name, String surname) {
		super();
		this.name = name;
		this.surname = surname;
	}

	public User() {
		super();
	}

	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getSurname() {
		return surname;
	}
	
	public void setSurname(String surname) {
		this.surname = surname;
	}
	
	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}
}
