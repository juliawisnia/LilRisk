<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="Servlets.*" %>
<!DOCTYPE html>
<html>
	<head>
		<title>Login</title>
		<style>
		* {
	font-family: Avenir Next;
	background-color: #242424;
}

#title {
	position: relative;
	color: white;
	font-size: 70px;
	margin-left: 1%;
}

#accnt {
	text-align: center;
	margin-left: 2.5%;
	color: white;
	font-size: 50px;
	margin-top: 10%;
}

.form-container {
	width: 668px;
	height: 369px;
	margin-left: auto;
	margin-right: auto;
	margin-top: auto;
}

ul.list {
	list-style-type: none;
	text-align: center;
}

input:focus,
select:focus,
textarea:focus,
button:focus {
    outline: none;
}

input {
	width: 97%;
	border-radius: 10px;
	border-style: solid white;
	border-width: 1px;
	font-size: 30px;
	color: #E0E0E0;
	padding: 10px 17px;
}

ul.list input[type=button] {
	font-size: 30px;
	width: 191px;
	background-color: #084179;
	color: #E0E0E0;
	border-radius: 15px;
	border-style: solid white;
	border-width: 1px;
	cursor: pointer;
}

/*ALERTS*/

.top {
	position: absolute;
	top: 10%;
	left: 30%;
	width: 534px;
	background-color: rgb(189, 189, 189, 0);
}
ul.alert {
	list-style-type: none;
	background-color: rgb(189, 189, 189, 0);
	padding: 0;
	text-align: center;
}

ul.alert li {
	background-color: rgb(0, 0, 0, .5);
	margin-bottom: 10px;
	color: white;
	padding: 10px;
	font-size: 25px;
	font-weight: lighter;
	border-radius: 10px;
}

.hide {
	display: none;  
}

		
		</style>
		<link rel="stylesheet" type="text/css" href="login.css" />
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	</head>
	<script>
		function login() {
			$.ajax({
				url: "LoginServlet",
				type: "POST",
				data: {
					email: document.getElementById('email').value,
					password: document.getElementById('pw').value,
				},
				success: function(result) {
					if (result === "success") {
						window.location.href = "home.jsp";
					}
					else {
						var noEmail = <%=session.getAttribute("no-email")%>;
						var noPw = <%=session.getAttribute("no-password")%>;
						var inUser = <%=session.getAttribute("invalid-username")%>;
						var noMatch = <%=session.getAttribute("no-match")%>;
						
						if (noEmail != null) document.getElementById("no-email").className = "show";
						if (noPw != null) document.getElementById("no-password").className = "show";
						if (inUser != null) document.getElementById("no-user").className = "show";
						if (noMatch != null) document.getElementById("no-match").className = "show";
					}
				}
			})
		}
	</script>
	<div id="title"><i>LIL RISK INC.</i></div>
	<hr style="border: 0.5px solid white;" />
	<body>
		<div id="accnt">Sign In</div>
		<div class="form-container">
			<ul class="list">
				<li><input type="email" id="email" onfocus="this.value=''" value="Email"></li></br>
				<li><input type="text" id="pw" onfocus="this.value=''; this.type='password'" value="Password"></li></br>
				<li><input type="button" onclick="login()" name="login" value="Login"></li>
			</ul>
		</div>
		<div class="top" id="alert">
			<ul class="alert">
				<li id="no-email" class="hide">Must enter an email.</li>
				<li id="no-password" class="hide">Must enter a password.</li>
				<li id="no-match" class="hide">Email and password do not match.</li>
				<li id="no-user" class="hide">No email exists.</li>
			</ul>
		</div>
	</body>
</html>