package com.model;



/**
 * This class represents the Hospitals. Each Hospital has a <b>name</b> and an <b>address</b>.
 * 
 * @authors telis, vasilis, atnwnis
 * 
 */
public class Hospital {
	
	private String name;
	private String address;
	
	/**
	 * Constructor of the Hospital Class.
	 * 
	 * @param name		The name of the Hospital
	 * @param address	The address of the Hospital
	 * 
	 */
	public Hospital(String name, String address) {
		this.setName(name);
		this.setAddress(address);
	}

	public Hospital(String name) {
		super();
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
}
