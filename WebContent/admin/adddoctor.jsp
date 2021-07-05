<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Add Doctor Form</title>
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
			<h1>Add a doctor</h1>
			<h2> <%= session.getAttribute("name") %> </h2>
		</div>
		
		<div class="navbar">
			<a href="index.jsp">Home</a>
			<a href="about.jsp">About</a>
			
			<a href="logout.jsp" class="right">Log out</a>
			<a href="admin?action=welcome" class="right"> <%= session.getAttribute("name") %> </a>
			<a href="admin?action=addpatient" class="right">Add a Patient</a>
			<a id="selected" href="admin?action=adddoctor" class="right">Add a Doctor</a>
			<a href="admin?action=addhospital" class="right">Add a Hospital</a>
			
		</div>
		
		<div class="offset"> </div>
		<h2><b>Add doctor.</b></h2>
		<form method="post" action="admin">
			<input type="hidden" name="action" value="insertdoctor" />
			<table>
			
				<tr>
					<td>AMKA:</td>
					<td><input type="text" name="amka" /></td>
				</tr>
				
				<tr>
					<td>Name:</td>
					<td><input type="text" name="name" /></td>
				</tr>
				
				<tr>
					<td>Surname:</td>
					<td><input type="text" name="surname" /></td>
				</tr>
				
				<tr>
					<td>Username:</td>
					<td><input type="text" name="username" /></td>
				</tr>
				
				<tr>
					<td>Password:</td>
					<td><input type="text" name="psw" /></td>
				</tr>
				
				<tr>
					<td>Specialty:</td>
					<td>
					
						<select name="sp">
						  <option value="Pathologist">Pathologist</option>
						  <option value="Ophthalmologist">Ophthalmologist</option>
						  <option value="Orthopedic">Orthopedic</option>
						</select>
					
					
					</td>
				</tr>
				
				<tr>
					<td>Hospital:</td>
					<td>
					
					<select name="hospital">
						
					<c:forEach items="${requestScope.Hospitals}" var="h">
					
						<option value= '<c:out value="${h.name}" />'><c:out value="${h.name}" /></option>
	
					</c:forEach>
					</select>
					
					</td>
				</tr>
				
				<tr>
					<td></td>
					<td><input type="submit" value="Add doctor" /></td>
				</tr>
	
			</table>
		</form>
		
		
		<br>
		<h3><b>Doctors in database:</b></h3>
		<table border=1>
	        <thead>
				<tr>
					<th>Doctor Username</th>
					<th>Doctor AMKA</th>
					<th>Doctor Name</th>
					<th>Doctor Surname</th>
					<th>Action</th>
				</tr>
	        </thead>
	        <tbody>
	            <c:forEach items="${requestScope.Doctors}" var="d">
					<tr>

						<td><c:out value="${d.username}" /></td>
						<td><c:out value="${d.AMKA}" /></td>
						<td><c:out value="${d.name}" /></td>
						<td><c:out value="${d.surname}" /></td>
						<td><a href="admin?action=delete&DoctorUsername=<c:out value="${d.username}"/>&DoctorAMKA=<c:out value="${d.AMKA}"/>">Delete</a></td>
					</tr>
	            </c:forEach>
	        </tbody>
		</table>

		<% String message = (String)request.getAttribute("message");%>
			
		<script>
		
			var x = "<%=message%>";
			if(x != "nomessage")
				alert(x);
			
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