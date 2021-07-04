package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.model.Admin;
import com.util.DbUtil;

public class AdminDao {

	private Connection connection;
	
	public AdminDao() {
		super();
		connection = DbUtil.getConnection();
	}

	
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
