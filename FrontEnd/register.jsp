<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Register</title>
		<link rel="stylesheet" type="text/css" href="register.css" />
	</head>
	<script>
		function create() {
			window.location.href = "login.jsp";
		}
	</script>
	<div id="title"><i>LIL RISK INC.</i></div>
	<hr style="border: 0.5px solid white;" />
	<body>
		<div id="accnt">Create Your Lil Risk Account</div>
		<div class="form-container">
			<ul class="list">
				<li><input type="text" id="fname" onfocus="this.value=''" value="First Name"></li></br>
				<li><input type="text" id="lname" onfocus="this.value=''" value="Last Name"></li></br>
				<li><input type="email" id="email" onfocus="this.value=''" value="Email"></li></br>
				<li><input type="text" id="pw" onfocus="this.value=''; this.type='password'" value="Password"></li></br>
				<li><input type="text" id="cpw" onfocus="this.value=''; this.type='password'" value="Confirm Password"></li></br>
				<li><input type="button" onclick="create()" name="create" value="Create"></li>
			</ul>
		</div>
	</body>
</html>