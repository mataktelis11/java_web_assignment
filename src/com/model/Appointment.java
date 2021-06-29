package com.model;


/**
 * This class represents the Appointments. Each object of type <i>Appointment</i> has a <b>Doctor</b>, a <b>Patient</b>, a <b>date</b> and a <b>time</b>.
 * 
 * @authors telis, vasilis, atnwnis
 * 
 */
public final class Appointment {

	private Doctor doctor;
	private Patient patient;
	private String datetime;
	private String endtime;
	private boolean availability;
	private Hospital hospital;
	
	public Doctor getDoctor() {
		return doctor;
	}
	public void setDoctor(Doctor doctor) {
		this.doctor = doctor;
	}
	public Patient getPatient() {
		return patient;
	}
	public void setPatient(Patient patient) {
		this.patient = patient;
	}
	public String getDatetime() {
		return datetime;
	}
	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public boolean getAvailability() {
		return availability;
	}
	public void setAvailability(boolean availability) {
		this.availability = availability;
	}
	public Hospital getHospital() {
		return hospital;
	}
	public void setHospital(Hospital hospital) {
		this.hospital = hospital;
	}





}
