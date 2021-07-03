<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Add Admin Form</title>
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
			<h1>Adding a patient</h1>
			<p> <%= session.getAttribute("name") %> </p>
		</div>
		
		<div class="navbar">
			<a href="index.jsp">Home</a>
			<a href="about.jsp">About</a>
			
			<a href="logout.jsp" class="right">Log out</a>
			<a href="headadmin?action=welcome" class="right"> <%= session.getAttribute("name") %> </a>
			<a id="selected" href="headadmin?action=addadmin" class="right">Add an Admin</a>
			
		</div>
		
		<div class="offset"> </div>
		
		<p>The admin can add a patient here.</p>
		<form method="post" action="headadmin">
			<input type="hidden" name="action" value="insertadmin" />
			<table>
				<tr>
					<td>Name:</td>
					<td><input type="text" name="name" /></td>
					<br />
				</tr>
				<tr>
					<td>Surname:</td>
					<td><input type="text" name="surname" /></td>
					<br />
				</tr>
				<tr>
					<td>Username:</td>
					<td><input type="text" name="username" /></td>
					<br />
				</tr>
				<tr>
					<td>Password:</td>
					<td><input type="text" name="psw" /></td>
					<br />
				</tr>
				
				<tr>
					<td></td>
					<td><input type="submit" value="Add admin" /></td>
					<br />
				</tr>
	
			</table>
		</form>
		
		
		<br>
		<p>Admins in the database:</p>
		<table border=1>
	        <thead>
				<tr>
					<th>Admin Username</th>
					<th>Added by</th>

				</tr>
	        </thead>
	        <tbody>
	            <c:forEach items="${requestScope.Admins}" var="a">
					<tr>
						<td><c:out value="${a.username}" /></td>
						<td><c:out value="${a.headAdmin}" /></td>

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