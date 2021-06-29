package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.model.User;
import com.util.DbUtil;

/**
 * 
 * Data Access Object class for all User types.<br>
 * 
 * 
 * @author telis, vasilis, atnwnis
 *
 */
public class UserDao {
	
	private Connection connection;

	public UserDao() {
		connection = DbUtil.getConnection();
	}

	/**
	 * Method that returns a User-type object with the attributes found on the database via the given username.<br>
	 * If the username isn't in the database, a null User-type object is returned.
	 * 
	 * @param username the username with which the method will search the user in the database.
	 * @return the User-type object found in the database. Null if it wasn't found.
	 */
	public User login(String username) {
		
		User user = null;
		
		try {
			PreparedStatement preparedStatement = connection.prepareStatement("select * from user where username=? ");

			preparedStatement.setString(1, username);

			ResultSet rs = preparedStatement.executeQuery();

			if (rs.next()) {
				user = new User();
				user.setUsername(rs.getString("username"));
				user.setName(rs.getString("firstname"));
				user.setRole(rs.getString("role"));
				user.setSalt(rs.getString("salt"));
				user.setPassword(rs.getString("hashedpassword"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return user;
	}
	
	

}
