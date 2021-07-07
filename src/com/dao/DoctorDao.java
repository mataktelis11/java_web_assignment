package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.Admin;
import com.model.Appointment;
import com.model.Doctor;
import com.model.Hospital;
import com.model.Patient;
import com.util.DbUtil;



/**
 * 
 * Data Access Object class for Doctors.<br>
 * 
 * 
 * @author telis, vasilis, atnwnis
 *
 */
public class DoctorDao {

	private Connection connection;
	
	public DoctorDao() {
		super();
		connection = DbUtil.getConnection();
	}
	
	
	
	
	/**
	 * Adds a user to the database with the role = 'doctor'
	 * @param patient to be added
	 * @return the number of affected rows in the database
	 */
	private int addDoctorUser(Doctor doctor) {

		
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("INSERT INTO user VALUES (?,?,?,?,?,'doctor');");
			preparedStatement.setString(1, doctor.getUsername());
			preparedStatement.setString(2, doctor.getPassword());
			preparedStatement.setString(3, doctor.getSalt());
			preparedStatement.setString(4, doctor.getName());
			preparedStatement.setString(5, doctor.getSurname());

			int count =  preparedStatement.executeUpdate();
			
			return count;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	
	/**
	 * Adds a doctor to the database
	 * @param doctor
	 * @return
	 */
	public int addDoctor(Doctor doctor) {

		//use the above method
		if(addDoctorUser(doctor)==0) return 0;
		
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("INSERT INTO doctor VALUES (?,?,?,?,?);");
			preparedStatement.setString(1, doctor.getUsername());
			preparedStatement.setString(2, doctor.getAMKA());
			preparedStatement.setString(3, doctor.getHospital().getName());
			preparedStatement.setString(4, doctor.getAdmin());
			preparedStatement.setString(5, doctor.getSpeciality());

			int count =  preparedStatement.executeUpdate();
			
			return count;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	
	/**
	 * Returns the amka of a doctor with the given username
	 * @param username
	 * @return
	 */
	public String getAmka(String username) {
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("select amka from doctor  where user_username = ?");
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
	
	
	/**
	 * Adds a new Appointment with dummy patient amka (5) and availability 1
	 * @param username
	 * @param date1
	 * @param date2
	 */
	public void addAvailableAppointment(String username,String date1,String date2) {
		String s=getAmka(username);
		try {
			PreparedStatement preparedstatement =connection.prepareStatement("INSERT INTO appointment VALUES (5,?,?,?,1);");
			preparedstatement.setString(1, s);
			preparedstatement.setString(2, date1);
			preparedstatement.setString(3, date2);
			
			int count = preparedstatement.executeUpdate();
			
		}catch (SQLException e) {
			e.printStackTrace();
		}
	
	}
	
	/**
	 * Get all Doctors of the Database
	 * @return
	 */
	public List<Doctor> getAllDoctors() {
		
		List<Doctor> doctors = new ArrayList<Doctor>();
		
		try {
			
			
			PreparedStatement preparedStatement = connection.
					prepareStatement("select username, amka, firstname, surname from doctor inner join user on doctor.user_username = user.username;");
			
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Doctor doctor = new Doctor();

				doctor.setName(rs.getString("firstname"));
				doctor.setSurname(rs.getString("surname"));
				doctor.setAMKA(rs.getString("amka"));
				doctor.setUsername(rs.getString("username"));
				
				doctors.add(doctor);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

		
		return doctors;
	}
	
	/**
	 * Get appointments of a doctor with availability 0
	 * @param amka
	 * @return
	 */
	public List<Appointment> getScheduledAppointments(String amka){
		
		List<Appointment> appointments = new ArrayList<Appointment>();
		
		try {
			
			
			PreparedStatement preparedStatement = connection.
					prepareStatement("select * from appointment where doctor_amka=? and availability=0;");
			
			preparedStatement.setString(1, amka);
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Appointment appointment = new Appointment();

				appointment.setPatient(new Patient(rs.getString("patient_amka")));
				appointment.setDatetime(String.valueOf(rs.getString("appdate")));
				appointment.setEndtime(String.valueOf(rs.getString("endtime")));

				appointments.add(appointment);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return appointments;
	}
	
	/**
	 * Delete an Appointment
	 * @param pamka patient_amka of the Appointment
	 * @param damka doctor_amka of the Appointment
	 * @param date appdate of the Appointment
	 */
	public void cancelAppointment(String pamka, String damka, String date) {
		
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("DELETE FROM appointment where patient_amka=? and doctor_amka=? and appdate=?;");
			preparedStatement.setString(1, pamka);
			preparedStatement.setString(2, damka);
			preparedStatement.setString(3, date);
			
			preparedStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * Gets the details of the Doctor
	 * @param username
	 * @return
	 */
	public Doctor getDetails(String username) {
		
		Doctor a = new Doctor();
		
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("select * from user where username = ?");
			preparedStatement.setString(1, username);
			ResultSet rs = preparedStatement.executeQuery();

			if (rs.next()) {
				
				a.setUsername(rs.getString("username"));
				a.setPassword(rs.getString("hashedpassword"));
				a.setName(rs.getString("firstname"));
				a.setSurname(rs.getString("surname"));
				a.setAMKA(getAmka(rs.getString("username")));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return a;
	}
	
	
	
	
	
	
	
	
	
	
}
