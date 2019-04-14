<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Login</title>
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