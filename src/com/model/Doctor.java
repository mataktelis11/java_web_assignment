package com.model;


/**
 * 
 * This is the class of the Doctors of the web application and a child of the User class. It has no children so it is <b>final</b>.
 * 
 * @authors telis, vasilis, atnwnis
 * 
 */
public final class Doctor extends User{


	private String speciality;
	private Hospital hospital;
	private boolean onHalt;
	private String AMKA;
	private String admin;
	
	/**
	 * Constructor of the Doctor Class.
	 * 
	 * @param username		The username of the Doctor
	 * @param password		The password of the Doctor
	 * @param name			The name of the Doctor
	 * @param surname		The surname of the Doctor
	 * @param speciality	The Doctor's speciality
	 * @param hospital		The hospital to which the Doctor is assigned
	 * @param amka		The AMKA of the Patient
	 * 
	 */
	public Doctor(String username, String password, String name, String surname,String speciality,Hospital hospital,String amka) {
		super(username, password, name, surname);
		this.speciality = speciality;
		this.hospital = hospital;
		this.AMKA = amka;
	}
	
	public Doctor(String name, String surname, String speciality) {
		super(name, surname);
		this.speciality = speciality;
	}
	
	public Doctor(String name, String surname, String speciality, String amka) {
		super(name, surname);
		this.speciality = speciality;
		this.AMKA = amka;
	}

	public Doctor() {
		super();
	}

	public String getSpeciality() {
		return speciality;
	}

	public void setSpeciality(String speciality) {
		this.speciality = speciality;
	}

	public Hospital getHospital() {
		return hospital;
	}

	public void setHospital(Hospital hospital) {
		this.hospital = hospital;
	}

	public boolean isOnHalt() {
		return onHalt;
	}

	public void setOnHalt(boolean onHalt) {
		this.onHalt = onHalt;
	}

	public String getAMKA() {
		return AMKA;
	}

	public void setAMKA(String aMKA) {
		AMKA = aMKA;
	}

	public String getAdmin() {
		return admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
	}
	
	
	
}
