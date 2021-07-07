package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.model.Admin;
import com.util.DbUtil;



/**
 * 
 * Data Access Object class for Admins.<br>
 * 
 * 
 * @author telis, vasilis, atnwnis
 *
 */
public class AdminDao {

	private Connection connection;
	
	public AdminDao() {
		super();
		connection = DbUtil.getConnection();
	}

	/**
	 * Get basic details of a Admin with the given username
	 * @param username
	 * @return
	 */
	public Admin getDetails(String username) {
		
		Admin a = new Admin();
		
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

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return a;
	}
	
	/**
	 * Remove a User with the given username
	 * @param username
	 * @return
	 */
	private int removeUser(String username) {
		
		
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("DELETE FROM user where username=?");
			preparedStatement.setString(1, username);

			int count =  preparedStatement.executeUpdate();
			
			return count;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
		
	}
	
	/**
	 * Remove a Doctor with the given username
	 * @param username
	 * @return
	 */
	public int removeDoctor(String username) {
		
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("DELETE FROM doctor where user_username=?");
			preparedStatement.setString(1, username);

			int count =  preparedStatement.executeUpdate();
			
			if(count > 0)
				removeUser(username);
			
			return count;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}

	}
	
	/**
	 * Delete Appointment with the given Doctor Amka
	 * @param amka
	 * @return
	 */
	public int removeAppointments(String amka) {
		
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("DELETE FROM appointment where doctor_amka=?");
			preparedStatement.setString(1, amka);

			int count =  preparedStatement.executeUpdate();
			
			return count;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	
}
