<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="style.css">
		<title>Registration complete</title>
		
		<style>
				
			/* Makes the text of the buttons unselectable */
			.unselectable {
			    -webkit-touch-callout: none;
			    -webkit-user-select: none;
			    -khtml-user-select: none;
			    -moz-user-select: none;
			    -ms-user-select: none;
			    user-select: none;
			}
			
			/* Header/logo Title */
			.header {
				padding: 60px;
				text-align: center;
				background-color: #4e5cde;
				color: #ddd;
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
				background-color: #4e5cde;
				color: #ddd;
				padding: 14px 20px;
				margin: 8px 0;
				border: none;
				border-radius: 4px;
				cursor: pointer;
			}
			
			input[type=submit]:hover {
				background-color: #606eeb;
			}
			
		</style>
		
	</head>
	<body class="unselectable">
		<% 
		session.removeAttribute("username");
		session.removeAttribute("name");
		session.removeAttribute("role");
		session.invalidate();
		%> 
		
		<div class="header">
			<h1>Register successful</h1>
			<p></p>
		</div>
		
		<div class="offset"> </div>
			
		<div class="main">
			<form action="login.html">
				<input type="submit" value="Log in" />
			</form>
		</div>
	</body>
</html>