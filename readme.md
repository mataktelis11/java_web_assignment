
# Java Web Project - Summer 2021

This project was made for an exam for the lesson **Web Programming**, in University of Piraeus IT department.

As the title suggests, this is a Java Web Application used for management of regular medical examinations (appointments). This application includes several categories of users such as *doctors*,*patients*,*administrators* and *Head administrators*, with different rights and functions for each category. The application is implemented with java Servlets and supports these basic functions:


* For the **Patients**:
    - Register via a form
    - Search for available appointments
    - Schedule appointments
    - Cancel a scheduled appointment (only if it is at least 3 days prior to today).
* For the **Doctors**:
    - Submit an availability timetable for the upcoming month
    - View scheduled appointments
    - Cancel a scheduled appointment (only if it is at least 3 days prior to today).
* For the **Administrators**:
    - Add Doctors to the Application
    - Add Patients to the Application
    - Add Hospitals to the Application
* For the **Head Administrators**:
    - Add Administrators to the Application




Application Dependencies:
1. A java IDE (e.g. Eclipse)
2. Apache Tomcat (v8 or v9 recommended) and hooked on your installed IDE
3. Download the latest **mysql-connector-java-X.X.X-bin.jar** from http://dev.mysql.com/downloads/connector/j/, and copy it to the **lib** folder in you Tomcat installation.
4. MySql and MySql Workbench


To run this application you need:
1. Opeb the **database_ver2.mwb** file with MySql Workbench and choose **Database > Forward Engineer**. A database with the name **doctorappointment** will be created. Make sure that the schema **doctorappointment** is the default one.
2. Open the **data.sql** file with MySql Workbench and execute it. This will add dummy data to the DataBase.
3. Paste the code below to the **context.xml** file of your Tomcat:  
`<Resource name="jdbc/ LiveDataSource " auth=" Container "`  
`	driverClassName ="com. mysql .jdbc. Driver "`  
`	type=" javax .sql. DataSource "`  
`	username ="root"`  
`	password =" test123 "`  
`	url=" jdbc:mysql: // localhost:3306 / doctorappointment "`  
`	maxActive ="8" >`  
`</ Resource >`  
Where **username** and **password** correspond to yours.  


You can now run the application. Log in to the dummy accounts using the passwords in the **data.sql** file.


