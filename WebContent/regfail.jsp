<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
	<head>
	
		<title>Registration failed.</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="style.css">
		
		<style>
		
			/* Header/logo Title */
			.header {
				padding: 60px;
				text-align: center;
				background-color: #ff3c00;
				color: #ffeae3;
			}
			
			body {
				background-color: #333;
			}
			
			.main {
				padding: 60px;
				text-align: center;
				background-color: #333;
				color: black;
			}
			
			input[type=submit] {
				width: 70%;
				font-size: 25px;
				background-color: #ff3c00;
				color: #ffeae3;
				padding: 14px 20px;
				margin: 8px 0;
				border: none;
				border-radius: 4px;
				cursor: pointer;
			}
			
			input[type=submit]:hover {
				background-color: #fc810d;
			}
			
		</style>
		
	</head>
	<body>
	
		<div class="header">
			<h1>Register failed!</h1>
			<p>Server message: <c:out value="${requestScope.message}" /></p>
		</div>
		
		<div class="offset"> </div>
			
		<div class="main">
			<form action="register.html">
				<input type="submit" value="Try again.." />
			</form>
		</div>
	</body>
</html>