package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.GregorianCalendar;

import com.util.DbUtil;

/**
 * 
 * Data Access Object class for Doctors only.<br>
 * 
 * 
 * @author telis, vasilis, atnwnis
 *
 */
public class DoctorDao {
	private Connection connection;
	
	
	public DoctorDao() {
		connection = DbUtil.getConnection();
	}
	
	public String getAmka(String username) {
		try {
			PreparedStatement preparedStatement = connection.
					prepareStatement("select * from user inner join doctor on user.username = doctor.user_username where user.username = ?");
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
	
	public void setApp(String username,String date1,String date2) {
		String s=getAmka(username);
		try {
			PreparedStatement preparedstatement =connection.prepareStatement("INSERT INTO appointment VALUES (1,?,?,?,1);");
			preparedstatement.setString(0, s);
			preparedstatement.setString(1, date1);
			preparedstatement.setString(0, date2);
			
			int count = preparedstatement.executeUpdate();
		}catch (SQLException e) {
			e.printStackTrace();
		}
	
}
	 public void fillDates(String username,String date) {
		//ArrayList<String> test = new ArrayList();
		
		
		String[] split = date.split(",");
		String[] s1=split[0].split("-");
		//System.out.println(s1[1]);
		Date x=  new GregorianCalendar(2020, 1, 20).getTime();
		ArrayList<String[]> spans=new ArrayList();
		//print day and spans
		for (int i=1;i<split.length;i++) {
			spans.add(split[i].split("-"));
			//System.out.println(Arrays.toString(spans.get(i-1))+(i-1));
		}
		//print spans
		for (int i=0;i<spans.size();i++) {
			
			
			int c=1;
			int month=1;
			try {
			LocalDate date2=LocalDate.of(Integer.parseInt(s1[1]),getDayMonth(s1[0]), 1);
			 for(int z=0;z<date2.lengthOfMonth();z++){
		            if(spans.get(i)[0].equalsIgnoreCase(date2.getDayOfWeek().toString())){

		                break;
		            }else{
		                date2=date2.plusDays(1);
		            }
		        }
			 c=date2.getDayOfMonth();
			 month=getDayMonth(s1[0]);
			 //System.out.println(date2.getDayOfYear());
			}catch(ParseException e) {
				e.printStackTrace();
			}
			YearMonth yearMonthObject = YearMonth.of(Integer.parseInt(s1[1]), month);
			int daysInMonth = yearMonthObject.lengthOfMonth();
			for (int k=c;k<=daysInMonth;k+=7) {
			x=  new GregorianCalendar(Integer.parseInt(s1[1]), month-1, k).getTime();
			
			for(int j=1;j<spans.get(i).length;j++) {
			String[] s=spans.get(i)[j].split("/");
			//System.out.println(Arrays.toString(s)+i+j);
			int from =Integer.parseInt(s[0]);
			int until=Integer.parseInt(s[1]);
			for (int a=from;a<until;a++) {
				x.setHours(a);
				x.setSeconds(0);
				for (int b=0;b<=30;b+=30) {
					x.setMinutes(b);
					java.sql.Date da = new java.sql.Date(x.getTime());
					String s2=da.toString()+" "+x.toString().substring(11, 20);
					Date y= x;
					if(b==30) {
						
						y.setHours(a+1);
						y.setMinutes(0);
						
					}else {
						y.setMinutes(30);
						}
					String s3=da.toString()+" "+y.toString().substring(11, 20);
					//test.add(s2+"// "+s3+'\n');
					setApp(username,s2,s3);
					}
				}
			}
		}
		}
		

		System.out.println(Arrays.toString(split));
		//System.out.println(test);
	}
	
	 public int getDayMonth(String s) throws ParseException {
		Date date = new SimpleDateFormat("MMMM").parse(s);
		//System.out.println(date);
		LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		return localDate.getMonthValue();
	}
}
