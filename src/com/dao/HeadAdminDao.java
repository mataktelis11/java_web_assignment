package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.HeadAdmin;
import com.model.Admin;
import com.util.DbUtil;


/**
 * 
 * Data Access Object class for HeadAdmins.<br>
 * 
 * 
 * @author telis, vasilis, atnwnis
 *
 */
public class HeadAdminDao {

	private Connection connection;

	public HeadAdminDao() {
		connection = DbUtil.getConnection();
		
	}
	
	/**
	 * Get basic details of a HeadAdmin with the given username
	 * @param username
	 * @return
	 */
	public HeadAdmin getDetails(String username) {
		
		HeadAdmin ha = new HeadAdmin();
		
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("select * from user where username = ?");
			preparedStatement.setString(1, username);
			ResultSet rs = preparedStatement.executeQuery();

			if (rs.next()) {
				
				ha.setUsername(rs.getString("username"));
				ha.setPassword(rs.getString("hashedpassword"));
				ha.setName(rs.getString("firstname"));
				ha.setSurname(rs.getString("surname"));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return ha;
	}
	
	/**
	 * Returns all Admins. Only gets their username and the username of the headadmin that added them.
	 * @return
	 */
	public List<Admin> getAllAdmins(){
		
		List<Admin> admins = new ArrayList<Admin>();
		
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("select user_username as admin, headadmin_user_username as headadmin from admin ;");
			
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Admin admin = new Admin();
				
				admin.setUsername(rs.getString("admin"));
				admin.setHeadAdmin(rs.getString("headadmin"));
				
				admins.add(admin);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return admins;
	}
	
	/**
	 * Adds a user to the database with role='admin'
	 * @param admin
	 * @return
	 */
	public int addAdminUser(Admin admin) {
		
		
		
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("INSERT INTO user VALUES (?,?,?,?,?,'admin');");
			preparedStatement.setString(1, admin.getUsername());
			preparedStatement.setString(2, admin.getPassword());
			preparedStatement.setString(3, admin.getSalt());
			preparedStatement.setString(4, admin.getName());
			preparedStatement.setString(5, admin.getSurname());

			int count =  preparedStatement.executeUpdate();
			
			return count;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}

		
	}
	
	/**
	 * Adds an admin to the database.
	 * @param admin
	 * @return
	 */
	public int addAdmin(Admin admin) {
		
		
		//use the above method
		if(addAdminUser(admin)==0) return 0;
		
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("INSERT INTO admin VALUES (?,?);");
			preparedStatement.setString(1, admin.getUsername());
			preparedStatement.setString(2, admin.getHeadAdmin());

			int count =  preparedStatement.executeUpdate();
			
			return count;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	
	
	
}
