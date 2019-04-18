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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<title>Register</title>
	</head>
	<script>
		function create() {
			$.ajax({
				url: "Register",
				type: "POST",
				data: {
					fname: document.getElementById('fname').value,
					lname: document.getElementById('lname').value,
					email: document.getElementById('email').value,
					pw: document.getElementById('pw').value,
					cpw: document.getElementById('cpw').value
				},
				success: function(result) {
					if (result === "success") {
						window.location.href = "home.jsp";
					}
					else {
						alert(result);
					}
				}
			})
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