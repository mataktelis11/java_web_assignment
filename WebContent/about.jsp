<!DOCTYPE html>
<html lang="en">
	<head>
		<title>About Page</title>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="style.css">
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
			
			*, *:before, *:after {
			  	box-sizing: inherit;
			}
			
			.column {
				float: left;
				width: 33.3%;
				margin-bottom: 16px;
				padding: 0 8px;
			}
			
			.card {
				box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
				background-color: #f0f1f7;
				margin: 100px;
			}
			
			.container {
				padding: 0 16px;
			}
			
			.container::after, .row::after {
				content: "";
				clear: both;
				display: table;
			}
			
			#special{
				background-color: #f44336;
				color: white;
				padding: 14px 25px;
				text-align: center;
				text-decoration: none;
				display: inline-block;
			}
		
		</style>
	</head>
	<body>
	
		<% 
			
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
			response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
			response.setHeader("Expires", "0"); // Proxies.
		
		%>
		
		<div class="unselectable">
			<div class="header">
			  	<h1>About Us</h1>
			  	<p>Some text about who we are and what we do.</p>
			</div>
			
			<div class="navbar">
				<a href="index.jsp">Home</a>
				<a id="selected" href="about.jsp">About</a>
	
				<% if(session.getAttribute("username")==null) { %>
				
					<a href="login.html" class="right">Log in</a>
					<a href="register.html" class="right">Register</a>
					
				<% } else if(session.getAttribute("role").equals("patient")){ %>
				<a href="logout.jsp" class="right">Log out</a>
					<a href="patient?action=welcome" class="right"> <%= session.getAttribute("name") %> </a>
					<a href="patient?action=appointments" class="right">Appointment menu</a>
					<a href="patient?action=availables" class="right">Available Appointments</a>
				
				<% } else if(session.getAttribute("role").equals("doctor")){ %>
					<a href="logout.jsp" class="right">Log out</a>
					<a href="doctor?action=welcome" class="right"> <%= session.getAttribute("name") %> </a>
					<a href="doctor?action=appointments" class="right">Appointment menu</a>
					<a href="doctor?action=appointmentdeclaration" class="right">Appointment declaration</a>
				
				<% } else if(session.getAttribute("role").equals("admin")){ %>
					<a href="logout.jsp" class="right">Log out</a>
					<a href="admin?action=welcome" class="right"> <%= session.getAttribute("name") %> </a>
					<a href="admin?action=addpatient" class="right">Add a Patient</a>
					<a href="admin?action=adddoctor" class="right">Add a Doctor</a>
					<a href="admin?action=addhospital" class="right">Add a Hospital</a>
					
				<% } else if(session.getAttribute("role").equals("headadmin")){ %>
					<a href="logout.jsp" class="right">Log out</a>
					<a href="headadmin?action=welcome" class="right"> <%= session.getAttribute("name") %> </a>
					<a href="headadmin?action=addadmin" class="right">Add an Admin</a>
				<% } %>
				
			</div>
		</div>
		
		<div class="offset"> </div>
		
		<h2 style="text-align:center">Our Team</h2>
		
		<div class="row">
	  		<div class="column">
	    		<div class="card">
	      			<img src="https://avatars.githubusercontent.com/u/58786697?v=4" alt="Basilis" style="width:100%">
	      			<div class="container">
	        			<h2>Bill</h2>
	        			<p>basilisgiata@gmail.com</p>
						<p><a href="https://github.com/basilisgiata" target="_blank" id="special">Visit Github</a></p>	
	      			</div>
	    		</div>
	  		</div>
	
	  		<div class="column">
	    		<div class="card">
	      			<img src="https://avatars.githubusercontent.com/u/61196956?v=4" alt="Aristotelis" style="width:100%">
	      			<div class="container">
	        			<h2>Telis</h2>
	        			<p>mataktelis01@gmail.com</p>
	        			<p><a href="https://github.com/mataktelis11" target="_blank" id="special">Visit Github</a></p>
	      			</div>
	    		</div>
	  		</div>
	  
			<div class="column">
				<div class="card">
			    	<img src="https://avatars.githubusercontent.com/u/59256516?v=4" alt="Antwnis" style="width:100%">
			      	<div class="container">
			        	<h2>Tony</h2>
			        	<p>	saviolidisalexandris@gmail.com</p>
			        	<p><a href="https://github.com/AnthonyAl" target="_blank" id="special">Visit Github</a></p>
			      	</div>
			    </div>
			</div>
		</div>
		<script>
			// navbar 
			
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
