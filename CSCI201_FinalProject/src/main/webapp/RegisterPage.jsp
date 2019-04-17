<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
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
	margin-top: 5%;
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


	
	</style>
		<title>Register</title>
	</head>
	<script>
		function create() {
			window.location.href = "login.jsp";
		}
	</script>
	<a href="UnregisteredHomePage.jsp" style="text-decoration: none"><div id="title"><i>LIL RISK</i></div></a>
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