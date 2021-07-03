package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.model.Doctor;
import com.util.DbUtil;

public class DoctorDao2 {

	private Connection connection;
	
	public DoctorDao2() {
		super();
		connection = DbUtil.getConnection();
	}
	
	
	
	
	/**
	 * Adds a user to the database with the role = 'patient'
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
	 * Adds a patient to the database'
	 * @param patient to be added
	 * @return the number of affected rows in the database
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
	
	
	

}
