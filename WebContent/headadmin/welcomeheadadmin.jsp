<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Welcome</title>
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
			<h1>Welcome</h1>
			<p> <%= session.getAttribute("name") %> </p>
		</div>
		
		<div class="navbar">
			<a href="index.jsp">Home</a>
			<a href="about.jsp">About</a>
			
			<a href="logout.jsp" class="right">Log out</a>
			<a id="selected" href="headadmin?action=welcome" class="right"> <%= session.getAttribute("name") %> </a>
			<a href="headadmin?action=addadmin" class="right">Add an Admin</a>
			
		</div>
		
		<div class="offset"> </div>
		
		<p>This is the welcome page of the headadmin.</p>
		<p>Details of this account:</p>
		
		<br>
		<table style="width:100%">
			<tr>
				<th>Username:</th>
				<td><c:out value="${HAdmin.username}"/></td>
			</tr>
			<tr>
				<th>FirstName:</th>
				<td><c:out value="${HAdmin.name}"/></td>
			</tr>
			<tr>
				<th>SurName:</th>
				<td><c:out value="${HAdmin.surname}"/></td>
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