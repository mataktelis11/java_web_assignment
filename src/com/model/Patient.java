package com.model;


/**
 * 
 * This is the class of the Patients of the web application and a child of the User class. It has no children so it is <b>final</b>.
 * 
 * @authors telis, vasilis, atnwnis
 * 
 */
public final class Patient extends User {
	
	private String AMKA;
	
	/**
	 * Constructor of the Patient Class.
	 * 
	 * @param username	The username of the Patient
	 * @param password	The password of the Patient
	 * @param name		The name of the Patient
	 * @param surname	The surname of the Patient
	 * @param amka		The AMKA of the Patient
	 * 
	 */
	public Patient(String username, String password, String name, String surname, String amka) {
		
		super(username, password, name, surname);	//call constructor of superclass
		this.AMKA = amka;	//set the AMKA
	}
	
	public Patient() {
		super();
	}

	public String getAMKA() {
		return AMKA;
	}

	public void setAMKA(String aMKA) {
		AMKA = aMKA;
	}
}

