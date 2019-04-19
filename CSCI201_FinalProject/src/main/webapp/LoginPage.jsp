<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
					username: document.getElementById('username').value,
					password: document.getElementById('pw').value
				},
				success: function(result) {
					if (result === "success") {
						window.location.href = "load.jsp";
					}
					else {
						alert(result);
					}
				}
			})
		}
	</script>
	<a href="UnregisteredHomePage.jsp" style="text-decoration: none"><div id="title"><i>LIL RISK INC.</i></div></a>
	<hr style="border: 0.5px solid white;" />
	<body>
		<div id="accnt">Sign In</div>
		<div class="form-container">
			<ul class="list">
				<li><input type="email" id="username" onfocus="this.value=''" value="Username"></li></br>
				<li><input type="text" id="pw" onfocus="this.value=''; this.type='password'" value="Password"></li></br>
				<li><input type="button" onclick="login()" name="login" value="Login"></li>
			</ul>
		</div>
	</body>
</html>