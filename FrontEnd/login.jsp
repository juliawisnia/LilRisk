<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Login</title>
		<link rel="stylesheet" type="text/css" href="login.css" />
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	</head>
	<script>
		function login() {
			window.location.href = "home.jsp";
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
	</body>
</html>