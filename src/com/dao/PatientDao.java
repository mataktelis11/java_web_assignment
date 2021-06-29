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
	 * Returns the List of Appointments of a given Patient.
	 * @param username of the Patient
	 * @return List of Appointments found in the database.
	 */
	public List<Appointment> getAppointments(String username) {
		
		List<Appointment> appointments = new ArrayList<Appointment>();
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("select user.firstname, user.surname, temp.doctor_specialty, temp.appdate, temp.endtime, temp.hospital "
							+ "from	(select doctor.user_username as doctor_username, doctor.speciality as doctor_specialty, doctor.hospital_hospname as hospital, appdate, endtime "
							+ "		from (appointment inner join patient on patient.amka = appointment.patient_amka) "
							+ "		inner join doctor on  doctor.amka = appointment.doctor_amka "
							+ "		where patient.user_username = ?) as temp"
							+ "		inner join user on user.username = temp.doctor_username");
			
			preparedStatement.setString(1, username);
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Appointment appointment = new Appointment();

				appointment.setDoctor(new Doctor(String.valueOf(rs.getString("firstname")), String.valueOf(rs.getString("surname")), String.valueOf(rs.getString("doctor_specialty"))));
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



}
