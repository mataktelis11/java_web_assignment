package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import com.model.Hospital;
import com.util.DbUtil;


public class HospitalDao {

	private Connection connection;
	
	public HospitalDao() {

		connection = DbUtil.getConnection();
	}

	public int addHospital(Hospital hospital) {
		
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("INSERT INTO hospital VALUES (?,?);");
			preparedStatement.setString(1, hospital.getName());
			preparedStatement.setString(2, hospital.getAddress());

			int count =  preparedStatement.executeUpdate();
			
			return count;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
		
	}
	
	public List<Hospital> getHospitals(){
		
		List<Hospital> hospitals = new ArrayList<Hospital>();
		try {
			
			
			PreparedStatement preparedStatement = connection.
					prepareStatement("select * from hospital;");
			
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Hospital hospital = new Hospital();

				hospital.setName(rs.getString("hospname"));
				hospital.setAddress(rs.getString("hospaddress"));
				
				hospitals.add(hospital);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return hospitals;
	}
}
