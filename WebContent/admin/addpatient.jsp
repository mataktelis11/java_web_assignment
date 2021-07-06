<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Add Patient Form</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="style.css">
		<style>
		
			.show {
				display: block;
			}
			
			/* Makes the text of the buttons unselectable */
			.unselectable {
			    -webkit-touch-callout: none;
			    -webkit-user-select: none;
			    -khtml-user-select: none;
			    -moz-user-select: none;
			    -ms-user-select: none;
			    user-select: none;
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
		
		<div class="unselectable">
			<div class="header">
				<h1>Add a patient</h1>
				<h2> <%= session.getAttribute("name") %> </h2>
			</div>
			
			<div class="navbar">
				<a href="index.jsp">Home</a>
				<a href="about.jsp">About</a>
				
				<a href="logout.jsp" class="right">Log out</a>
				<a href="admin?action=welcome" class="right"> <%= session.getAttribute("name") %> </a>
				<a id="selected" href="admin?action=addpatient" class="right">Add a Patient</a>
				<a href="admin?action=adddoctor" class="right">Add a Doctor</a>
				<a href="admin?action=addhospital" class="right">Add a Hospital</a>
				
			</div>
		</div>
		
		<div class="offset"> </div>
		
		<h2><b>Add patient:</b></h2>
		<form method="post" action="admin">
			<input type="hidden" name="action" value="insertpatient" />
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
					<td></td>
					<td><input type="submit" value="Add patient" /></td>
				</tr>
	
			</table>
		</form>
		
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