<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Home Page</title>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="style.css">
		<style>
			
			.mySlides {
				display: none;
			}
			  	
			img {
				vertical-align: middle;
			}
			
			/* Slideshow container */
			.slideshow-container {
				max-width: 1000px;
				position: relative;
				margin: auto;
			}
			
			
			
			/* Number text (1/3 etc) */
			.numbertext {
				color: #f2f2f2;
				font-size: 12px;
				padding: 8px 12px;
				position: absolute;
				top: 0;
			}
			
			/* The dots/bullets/indicators */
			.dot {
				height: 15px;
				width: 15px;
				margin: 0 2px;
				background-color: #bbb;
				border-radius: 50%;
				display: inline-block;
				transition: background-color 0.6s ease;
			}
			
			.active {
				background-color: #717171;
			}
			
			/* Fading animation */
			.fade {
				-webkit-animation-name: fade;
				-webkit-animation-duration: 10s;
				animation-name: fade;
				animation-duration: 10s;
			}
			
			@-webkit-keyframes fade {
				0%   { opacity:0.4; }
				50%  { opacity:1; }
				100% { opacity:0; }
			}
			
			@keyframes fade {
				0%   { opacity:0.4; }
				50%  { opacity:1; }
				100% { opacity:0; }
			}
		
		</style>
	</head>
	<body>
	
		<div class="header">
			<h1>Web Health</h1>
			<p>Doctor appointment search service</p>
		</div>
		
		<div class="navbar">
			<a id="selected" href="index.jsp">Home</a>
			<a href="about.jsp">About</a>
			
			<% if(session.getAttribute("username")==null) { %>
			
				<a href="login.html" class="right">Log in</a>
				<a href="register.html" class="right">Register</a>
				
			<% } else if(session.getAttribute("role").equals("patient")){ %>
				<a href="logout.jsp" class="right">Log out</a>
				<a href="patient?action=welcome" class="right"> <%= session.getAttribute("name") %> </a>
				<a href="patient?action=details" class="right">Account Details</a>
				<a href="patient?action=appointments" class="right">Appointment menu</a>
				
			<% } else if(session.getAttribute("role").equals("doctor")){ %>
				<a href="logout.jsp" class="right">Log out</a>
				<a href="doctor?action=welcome" class="right"> <%= session.getAttribute("name") %> </a>
				<a href="doctor?action=appointments" class="right">Appointment menu</a>
				<a href="doctor?action=appointmentdeclaration" class="right">Appointment declaration</a>
			<% } %>
		</div>
		
		
		<div class="offset"> </div>
	
		<h2>Application of Medical Examination Management</h2>
		<h5>Through the application you have the opportunity to make and manage appointments in our Primary Health Care Units.</h5>
		
		<div class="slideshow-container">
			<div class="mySlides fade">
		  		<div class="numbertext">1 / 3</div>
		  		<img src="res/index1.png" style="width:100%">
			</div>
		
			<div class="mySlides fade">
		  		<div class="numbertext">2 / 3</div>
		  		<img src="res/index2.png" style="width:100%">
			</div>
		
			<div class="mySlides fade">
				<div class="numbertext">3 / 3</div>
				<img src="res/index3.png" style="width:100%">
			</div>
		</div>
		
		<br>
		
		<div style="text-align:center">
			<span class="dot"></span> 
			<span class="dot"></span> 
			<span class="dot"></span> 
		</div>
	
		<script>
			var slideIndex = 0;
			showSlides();
			
			function showSlides() {
			  	var i;
				var slides = document.getElementsByClassName("mySlides");
			  	var dots = document.getElementsByClassName("dot");
			  	for (i = 0; i < slides.length; i++) {
			    	slides[i].style.display = "none";  
			  	}
			  	slideIndex++;
			  	if (slideIndex > slides.length) {
			  		slideIndex = 1
			  	}    
			  	for (i = 0; i < dots.length; i++) {
			    	dots[i].className = dots[i].className.replace(" active", "");
			  	}
			  	slides[slideIndex-1].style.display = "block";  
			  	dots[slideIndex-1].className += " active";
			  	setTimeout(showSlides, 7000); // Change image every couple of seconds.
				}
			
			// navbar 
			
			var prevScrollpos = window.pageYOffset;
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