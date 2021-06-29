<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Details</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="style.css">
		<style>
		
			.show {
				display: block;
			}
			
		</style>
	</head>
	<body>
		
		<% 
			
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
			response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
			response.setHeader("Expires", "0"); // Proxies.
		
			if(session.getAttribute("username")==null)
			{
				response.sendRedirect("login.html");
			}
		
		%>
		
		
		
		
		
		<div class="header">
			<h1>Details of</h1>
			<p> <c:out value='${sessionScope.username}'/></p>
		</div>
		
		<div class="navbar">
			<a href="index.jsp">Home</a>
			<a href="about.jsp">About</a>
			
			<a href="logout.jsp" class="right">Log out</a>
			<a href="patient?action=welcome" class="right"> <%= session.getAttribute("name") %> </a>
			<a id="selected" href="patient?action=details" class="right">Account Details</a>
			<a href="patient?action=appointments" class="right">Appointment menu</a>
			
		</div>
		
		
		<div class="offset"> </div>
		
			
		<br>
		<table style="width:100%">
			<tr>
				<th>Username:</th>
				<td><c:out value="${Patient.username}"/></td>
			</tr>
			<tr>
				<th>Password:</th>
				<td><c:out value="${Patient.password}"/></td>
			</tr>
			<tr>
				<th>FirstName:</th>
				<td><c:out value="${Patient.name}"/></td>
			</tr>
			<tr>
				<th>SurName:</th>
				<td><c:out value="${Patient.surname}"/></td>
			</tr>
			<tr>
				<th>AMKA:</th>
				<td><c:out value="${Patient.AMKA}"/></td>
			</tr>
		</table>
		
		<script>
			//navbar 
			
			window.onscroll = function() {
				if(window.pageYOffset >= document.getElementsByClassName("header")[0].clientHeight) {
					document.getElementsByClassName("offset")[0].style.height = (document.getElementsByClassName("navbar")[0].clientHeight + "px");
					document.getElementsByClassName("navbar")[0].style.top = "0";
					document.getElementsByClassName("navbar")[0].style.position = "fixed";
				}
				else {
					document.getElementsByClassName("navbar")[0].style.position = "relative";
					document.getElementsByClassName("offset")[0].style.height = "0px";
				}
			}
		</script>
		
	</body>
</html>