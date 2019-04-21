<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="coinData.*" %>
<%@ page session="true"%>

<!DOCTYPE html>
<html>
<style>
* {
	font-family: Avenir Next;
	background-color: #242424;
}

#title {
	color: white;
	font-size: 70px;
	margin-left: 1%;
	z-index: 1;
}

html,body {
	height: 100%;
	max-width: 100%;
	overflow-y: hidden;
}

.portfolio-name {
	color: white;
	font-size: 45px;
	font-weight: lighter;
	margin-left: 1%;
	margin-top: .5%;
	position: absolute;
	z-index: 2;
}

.form-container {
	height: 100%;
	width: 320px; 	
	position: fixed;
	z-index: 1;
	top: 0;
	right: 0;
	background-color: #313030;
	overflow-x: hidden;
	border-left: 1px solid white;
	padding: 100px 0px;
	position: fixed;
}
ul.PortfolioSideBar {
	/* overflow-y: auto; */
	width: 100%;
	list-style-type: none;
	padding: 0;
	border-bottom: white;
}

ul.PortfolioSideBar li:first-child {
	background-color: #313030;
	border-bottom: 1px solid white;
	text-transform: uppercase;
	font-size: 30px;
	color: white;
	font-weight: lighter;
	padding-top: 0px;
}

ul.PortfolioSideBar li {
	background-color: #313030;
	border-bottom: 1px solid white;
	text-transform: uppercase;
	font-size: 30px;
	color: white;
	font-weight: lighter;
	padding: 12px;
}

ul.PortfolioSideBar input[type=button].none {
	background-color: #313030;
	border-bottom: 1px solid white;
	text-transform: uppercase;
	font-size: 30px;
	color: white;
	font-weight: lighter;
	padding: 12px;
	color: white;
	cursor: pointer;
	text-transform: uppercase;
	font-weight: lighter;
	border: none;
	background-color: rgba(0,0,0,0);
	padding: 0px;
}

ul.StockSideBar {
	width: 100%;
	list-style-type: none;
	padding: 0;
	border-bottom: white;
	overflow-y: scroll;
}

ul.StockSideBar li {
	background-color: rgba(0,0,0,0);
	padding-left: 15px;
	color: white;
}

ul.StockSideBar li.symbol {
	text-transform: uppercase;
	padding-top: 5px;
	font-size: 30px;
}
ul.StockSideBar li.company {
	font-size: 12px;
	padding-bottom: 12px;
	border-bottom: 1px solid white;
}

a {text-decoration: none; color: white; background-color: rgba(0,0,0,0);}

.per {
	margin-top: 2.5%;
	position: absolute;
	right: 20px;
	border: 1px solid;
	border-color: #E10808;
	border-radius: 10px;
	font-size: 15px;
	display: inline-block;
	background: #313030;
	padding-left: 7px;
	padding-right: 7px;
	color: #E10808;
}

#portfolioButton {
	background-color: #7d7d7d;
	border: 1px solid white;
	border-radius: 10px;
	color: white;
	padding-right: 10px;
	padding-left:10px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 10px;
	margin: 2px 2px;
	cursor: pointer;
	z-index: 4; 
	position: absolute;
	top: 80px;
	right: 165px;
}

#stocksButton {
	background-color: #313030;
	border: 1px solid white;
	color: white;
	border-radius: 10px;
	padding-right: 20px;
	padding-left: 20px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 10px;
	margin: 2px 2px;
	cursor: pointer;
	z-index: 4; 
	position: absolute;
	top: 80px;
	right: 55px;
}

.portPer {
	right: 20px;
	position: absolute;
	border: 1px solid;
	border-color: #E10808;
	border-radius: 10px;
	font-size: 15px;
	display: inline-block;
	background: #313030;
	padding-left: 7px;
	padding-right: 7px;
	color: #E10808;
	margin-top: -2%;
}

.price {
	right: 21px;
	font-size: 15px;
	display: inline-block;
	position: absolute;
	color: white;
	background-color: rgba(0,0,0,0);
	padding-top: 5px;
}

input:focus,
select:focus,
textarea:focus,
button:focus {
    outline: none;
}


.friends-container {
	max-height: 400px;
	overflow-y: scroll;
	margin-left: 5%;
	margin-top: 10%;
}

.friendsPortfolios {
	text-align: center;
	border-collapse: collapse;
	color: white;
	width: 75%;
}

.friendsPortfolios td, .friendsPortfolios th {
	border: 1px solid #ddd;
	padding: 8px;
}

.friendsPortfolios th {
	padding-top: 12px;
	padding-bottom: 12px;
	color: white;
	font-size: 30px;
}

.friendsPortfolios tr:last-child {
	border: none;
}

.sb {
	text-transform: uppercase;
	border: none;
	color: white;
	background-color: rgba(0,0,0,0);
	padding: 0;
	cursor: pointer;
}

input[type=button].add {
	width: 25px;
	height: 25px;
	line-height: 15px;
	border-radius: 50%;
	border: 1px solid;
	border-color: #E10808;
	font-size: 25px;
	font-weight: lighter;
	color: #E10808;
	padding: 0px;
	cursor: pointer;
}

</style>
	<head>
		<%
				UserClass user = (UserClass)session.getAttribute("user");
		%>
		<!-- SIDEBAR SCRIPT -->
		<script> 

			function changeSideBar() {
				if (document.getElementById('PortfolioSideBar').style.display === 'none') {
					document.getElementById('stocksButton').style.backgroundColor = '#313030';
					document.getElementById('portfolioButton').style.backgroundColor = '#7d7d7d';
					document.getElementById('PortfolioSideBar').style.display = 'inline';
					document.getElementById('StockSideBar').style.display = 'none';
					document.getElementById('buy').style.display = 'none';
				}
				else {
					document.getElementById('stocksButton').style.backgroundColor = '#7d7d7d';
					document.getElementById('portfolioButton').style.backgroundColor = '#313030';
					document.getElementById('PortfolioSideBar').style.display = 'none';
					document.getElementById('StockSideBar').style.display = 'inline';
					document.getElementById('buy').style.display = 'inline';
				}
			}
		</script>
		<script>
 		function port(element) {
			$.ajax({				
				url: "SendToPort",
				type: "POST",
				data: {
					name: element.value
				},
				success: function(result) {
					if (result === "success") {
						location.reload(true);
					}
				}
			})
 		}
		</script>
		
		<meta charset="UTF-8">
		<title>Lil Risk</title>
	</head>
	<body id="body">
		
	<div id="title"><i><a href="home.jsp">LIL RISK INC.</a></i></div>
	<input type="button" id="stocksButton" value="REQUESTS" onclick= "changeSideBar()">
	<input type="button" id="portfolioButton" value="FRIENDS" onclick= "changeSideBar()">
	<hr style="border: 0.5px solid white;" />
	<body>
		<div class="portfolio-name" id="curr" style="text-transform: uppercase;">FRIEND'S PORTFOLIOS</div>
		<div class="form-container">
			<hr style="border: 0.5px solid white; margin-top: 12px;" />
			<ul class="PortfolioSideBar" id="PortfolioSideBar">
			<% 
				String[] friends = user.getFriendNames();
				for (int i = 0; i < friends.length; i+=2) {
			%>
 				<li><%=friends[i] %></li>
 			<%} %>
			</ul>
			<ul class="StockSideBar" id="StockSideBar" style="display: none;">
			<% 
				String[] requests = user.checkFriends();
				for (int i = 0; i < requests.length; i++) {
			%>
 				<li ><input type="button" class="accept" value="+"><%=requests[i] %><input type="button" class="decline" value="-"></li>
 			<%} %>
			</ul>
		</div>

		<div class="friends-container">
			<table class="friendsPortfolios">
				<tr>
					<th>User</th>
					<th>Portfolio</th>
					<th>Percent Change</th>
					
				</tr>
 				<%
					String[] friendsData = user.getFriendsPortfoliosString();
					for (int i = 0; i < friendsData.length; i+=4) {
						String userName = friendsData[i];
						String portfolio = friendsData[i+1]; 
						double glp = Double.parseDouble(friendsData[i+2]);
						String isYours = friendsData[i+3];
						String gainColor = "green";
						if (glp < 0) {
							gainColor = "red";
							glp = Math.abs(glp);
						}
						String gp = Double.toString(glp) + "%";
				%>
				<tr><td><%=userName %></td><td><%=portfolio %></td><td style="color: <%=gainColor%>;"><%=gp %></td>		
				<%} %> 
			</table>
		</div>
	</body>
</html>