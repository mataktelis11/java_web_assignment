package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import com.model.Patient;
import com.model.Appointment;
import com.model.Doctor;
import com.model.Hospital;
import com.util.DbUtil;

/**
 * 
 * Data Access Object class for Patients only.<br>
 * 
 * 
 * @author telis, vasilis, atnwnis
 *
 */
public class PatientDao{

	private Connection connection;

	public PatientDao() {
		connection = DbUtil.getConnection();
	}

	/**
	 * Returns the Patient object (that corresponds to the given username) with the attributes found in the database
	 * @param username username of the Patient in the database
	 * @return Patient Object with the attributes in the database
	 */
	public Patient getPatientDetails(String username) {
		Patient patient = new Patient();
		
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("select * from user inner join patient on user.username = patient.user_username where user.username = ?");
			preparedStatement.setString(1, username);
			ResultSet rs = preparedStatement.executeQuery();

			if (rs.next()) {
				
				patient.setUsername(rs.getString("username"));
				patient.setPassword(rs.getString("hashedpassword"));
				patient.setName(rs.getString("firstname"));
				patient.setSurname(rs.getString("surname"));
				patient.setRole(rs.getString("role"));
				patient.setAMKA(String.valueOf(rs.getLong("amka")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return patient;
	}
	
	
	
	/**
	 * Adds a user to the database with the role = 'patient'
	 * @param patient to be added
	 * @return the number of affected rows in the database
	 */
	private int addPatientUser(Patient patient) {

		
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("INSERT INTO user VALUES (?,?,?,?,?,'patient');");
			preparedStatement.setString(1, patient.getUsername());
			preparedStatement.setString(2, patient.getPassword());
			preparedStatement.setString(3, patient.getSalt());
			preparedStatement.setString(4, patient.getName());
			preparedStatement.setString(5, patient.getSurname());

			int count =  preparedStatement.executeUpdate();
			
			return count;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	
	/**
	 * Adds a patient to the database'
	 * @param patient to be added
	 * @return the number of affected rows in the database
	 */
	public int addPatient(Patient patient) {

		//use the above method
		if(addPatientUser(patient)==0) return 0;
		
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("INSERT INTO patient VALUES (?,?);");
			preparedStatement.setString(1, patient.getUsername());
			preparedStatement.setString(2, patient.getAMKA());

			int count =  preparedStatement.executeUpdate();
			
			return count;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	
	

	/**
	 * Returns the List of Appointments of a given Patient.
	 * @param username of the Patient
	 * @return List of Appointments found in the database.
	 */
	public List<Appointment> getAppointments(String username) {
		
		List<Appointment> appointments = new ArrayList<Appointment>();
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("select user.firstname, user.surname, temp.doctor_specialty, temp.appdate, temp.endtime, temp.hospital, damka, pamka "
							+ "from	(select doctor.user_username as doctor_username, doctor.speciality as doctor_specialty, doctor.hospital_hospname as hospital, appdate, endtime, doctor.amka as damka, patient.amka as pamka "
							+ "		from (appointment inner join patient on patient.amka = appointment.patient_amka) "
							+ "		inner join doctor on  doctor.amka = appointment.doctor_amka "
							+ "		where patient.user_username = ?) as temp"
							+ "		inner join user on user.username = temp.doctor_username");
			
			preparedStatement.setString(1, username);
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Appointment appointment = new Appointment();

				appointment.setDoctor(new Doctor(String.valueOf(rs.getString("firstname")), String.valueOf(rs.getString("surname")), String.valueOf(rs.getString("doctor_specialty")), String.valueOf(rs.getString("damka"))));
				appointment.setDatetime(String.valueOf(rs.getString("appdate")));
				appointment.setEndtime(String.valueOf(rs.getString("endtime")));
				appointment.setHospital(new Hospital(rs.getString("hospital")));
				appointment.setPatient(new Patient(String.valueOf(rs.getString("pamka"))));
				appointments.add(appointment);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return appointments;
	}
	
	
	/**
	 * Returns the List of Available Appointments.
	 * @return List of Available Appointments found in the database.
	 */
	public List<Appointment> getAvailableAppointments() {
			
		List<Appointment> appointments = new ArrayList<Appointment>();
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("select user.firstname, user.surname, temp.doctor_specialty, temp.appdate, temp.endtime, temp.hospital, damka "
							+ "from	(select doctor.user_username as doctor_username, doctor.speciality as doctor_specialty, doctor.hospital_hospname as hospital, appdate, endtime, doctor.amka as damka "
							+ "		from (appointment inner join patient on patient.amka = appointment.patient_amka) "
							+ "		inner join doctor on  doctor.amka = appointment.doctor_amka "
							+ "		where appointment.availability = 1) as temp"
							+ "		inner join user on user.username = temp.doctor_username");
			
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Appointment appointment = new Appointment();

				appointment.setDoctor(new Doctor(String.valueOf(rs.getString("firstname")), String.valueOf(rs.getString("surname")), String.valueOf(rs.getString("doctor_specialty")), String.valueOf(rs.getString("damka"))));
				appointment.setDatetime(String.valueOf(rs.getString("appdate")));
				appointment.setEndtime(String.valueOf(rs.getString("endtime")));
				appointment.setHospital(new Hospital(rs.getString("hospital")));
				appointments.add(appointment);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return appointments;
	}
	
	/**
	 * Returns the List of Available Appointments.
	 * @param speciality of the doctor
	 * @return List of Available Appointments found in the database.
	 */
	public List<Appointment> getAvailableAppointments(String speciality) {
			
		List<Appointment> appointments = new ArrayList<Appointment>();
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("select user.firstname, user.surname, temp.doctor_specialty, temp.appdate, temp.endtime, temp.hospital, damka "
							+ "from	(select doctor.user_username as doctor_username, doctor.speciality as doctor_specialty, doctor.hospital_hospname as hospital, appdate, endtime, doctor.amka as damka "
							+ "		from (appointment inner join patient on patient.amka = appointment.patient_amka) "
							+ "		inner join doctor on  doctor.amka = appointment.doctor_amka "
							+ "		where appointment.availability = 1 and doctor.speciality = ?) as temp"
							+ "		inner join user on user.username = temp.doctor_username");
			
			preparedStatement.setString(1, speciality);
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Appointment appointment = new Appointment();

				appointment.setDoctor(new Doctor(String.valueOf(rs.getString("firstname")), String.valueOf(rs.getString("surname")), String.valueOf(rs.getString("doctor_specialty")), String.valueOf(rs.getString("damka"))));
				appointment.setDatetime(String.valueOf(rs.getString("appdate")));
				appointment.setEndtime(String.valueOf(rs.getString("endtime")));
				appointment.setHospital(new Hospital(rs.getString("hospital")));
				appointments.add(appointment);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return appointments;
	}


	
	public void cancelAppointment(String pamka, String damka, String date) {
		
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("UPDATE appointment set availability=1,patient_amka=5 where patient_amka=? and doctor_amka=? and appdate=?;");
			preparedStatement.setString(1, pamka);
			preparedStatement.setString(2, damka);
			preparedStatement.setString(3, date);
			
			preparedStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void addAppointment(String pamka, String damka, String date) {
		
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("UPDATE appointment set availability=0,patient_amka=? where patient_amka='5' and doctor_amka=? and appdate=?;");
			preparedStatement.setString(1, pamka);
			preparedStatement.setString(2, damka);
			preparedStatement.setString(3, date);
			
			preparedStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public String getAmka(String username) {
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("select amka from patient  where user_username = ?");
			preparedStatement.setString(1, username);
			ResultSet rs = preparedStatement.executeQuery();
			
			if(rs.next()) {
				return String.valueOf(rs.getLong("amka"));
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return "0";
	}

}
