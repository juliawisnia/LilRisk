<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Home</title>
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

html, body {
	height: 100%;
	max-width: 100%;
	overflow-y: hidden;
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
	overflow-y: auto;
	border-left: 1px solid white;
	padding: 100px 0px;
}

ul.sidebar {
	/* overflow-y: auto; */
	width: 100%;
	list-style-type: none;
	padding: 0;
	border-bottom: white;
}

ul.sidebar li:first-child {
	background-color: #313030;
	border-bottom: 1px solid white;
	text-transform: uppercase;
	font-size: 30px;
	color: white;
	font-weight: lighter;
	padding-top: 0px;
}

ul.sidebar li {
	background-color: #313030;
	border-bottom: 1px solid white;
	text-transform: uppercase;
	font-size: 30px;
	color: white;
	font-weight: lighter;
	padding: 12px;
}


input:focus,
select:focus,
textarea:focus,
button:focus {
    outline: none;
}

.per {
	vertical-align: 30%;
	margin-right: 10px;
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

input[type=button].add {
	position: absolute;
	right: 15px;
	margin-top: 1.5%;
	width: 29px;
	height: 29px;
	line-height: 29px;
	border-radius: 50%;
	border: 1px solid;
	border-color: #E10808;
	background: #313030;
	font-size: 25px;
	font-weight: lighter;
	color: #E10808;
	display: inline-block;
	padding: 0px;
	cursor: pointer;
}

input[type=button].addNew {
	position: absolute;
	right: 15px;
	margin-top: 1.5%;
	width: 29px;
	height: 29px;
	line-height: 29px;
	border-radius: 50%;
	border: 1px solid;
	border-color: #E10808;
	background: #313030;
	font-size: 25px;
	font-weight: lighter;
	color: #E10808;
	display: inline-block;
	padding: 0px;
	cursor: pointer;
}

.center {
	position: absolute;
	width: 534px;
	height: 315px;
	background-color: rgb(189, 189, 189, 0.6);
	left: 30%;
	top: 30%;
	border-radius: 15px;
	padding: 0px;
}

ul.new-portfolio {
	list-style-type: none;
	text-align: center;
	margin-right: 5%;
}

ul.new-portfolio, ul.new-portfolio li {
	background-color: rgb(189, 189, 189, 0);
}

input {
	border-radius: 10px;
	border-style: solid white;
	border-width: 1px;
	font-size: 30px;
	color: #E0E0E0;
	padding: 10px 17px;
	background-color: rgb(189, 189, 189, .2);
}

ul.new-portfolio input[type=button].create {
	cursor: pointer;
	font-size: 30px;
	width: 155px;
	height: 50px;
	background-color: #084179;
	color: #E0E0E0;
	border-radius: 15px;
	border-style: solid white;
	border-width: 1px;
	border-color: white;
	text-align: center;
}

a {text-decoration: none; color: white; background-color: rgba(0,0,0,0);}

#dollar {
	position: absolute;
	background-color: rgb(189, 189, 189, 0);
	margin-left: 6%;
	margin-top: 2%;
	font-size: 30px;
	color: #E0E0E0;
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

.time-frames {
	position: relative;
	margin-top: -3%;
	margin-left: 6%;
	border-collapse: collapse;
}

input[type=button].time {
	cursor: pointer;
	border: none;
	background-color: rgba(0,0,0,0);
	font-size: 20px;
}

input[type=button].none {
	cursor: pointer;
	text-transform: uppercase;
	font-weight: lighter;
	border: none;
	background-color: rgba(0,0,0,0);
	padding: 0px;
}

input[type=button].lr {
	position: absolute;
	right: 15px;
	margin-top: 1.5%;
	width: 29px;
	height: 29px;
	line-height: 29px;
	border-radius: 50%;
	border: 1px solid;
	border-color: #E10808;
	background: #313030;
	font-size: 25px;
	font-weight: lighter;
	color: #E10808;
	display: inline-block;
	padding: 0px;
	cursor: pointer;
}

#logout {
	position: absolute;
	background-color: #313030;
	border: 1px solid white;
	border-radius: 20px;
	color: white;
 	padding-right: 91px;
	padding-left: 20px; 
	text-align: center;
	font-size: 15px;
	cursor: pointer;
	z-index: 5;
	top: 4%; right: 9.5%;
}

#friends {
	position: absolute;
	background-color: #313030;
	border: 1px solid white;
	color: white;
	border-radius: 60px;
 	padding-right: 80px;
	padding-left: 20px; 
	text-align: center;
	font-size: 15px;
	cursor: pointer;
	z-index: 5;
	top: 4%; right: 2.5%;
}

</style>
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
		<script type="text/javascript">

		google.charts.load('current', {packages: ['corechart', 'line']});
		google.charts.setOnLoadCallback(drawBasic);
		function addLine(element) {
			var a = element.value;
			if (a === '+') element.value = '-';
			else element.value = '+';
		}
		
		function drawBasic() {
			var data = new google.visualization.DataTable();
			
			data.addColumn('number', 'X');
			<%
				String timeFrame = (String)(session.getAttribute("timeFrame"));
				String[] syms = null;
				if (timeFrame.equals("day")) syms = (String[])(session.getAttribute("homeDayVals"));
				else if (timeFrame.equals("week")) syms = (String[])(session.getAttribute("homeWeekVals"));
				else if (timeFrame.equals("month")) syms = (String[])(session.getAttribute("homeMonthVals"));
				else if (timeFrame.equals("sixMonth")) syms = (String[])(session.getAttribute("homeSixMonthVals"));
				else syms = (String[])(session.getAttribute("homeYearVals"));
				
				String sym = "";
				for (int i = 0; i < syms.length - 1; i+=2) {
					sym = syms[i];
			%>
			data.addColumn('number', '<%=sym %>');
			<%}%>
			
			var vals; 
			var timeFrame = "<%= session.getAttribute("timeFrame")%>";
			
			if (timeFrame === "day") {
				vals = <%=session.getAttribute("homeDayData")%>;
				document.getElementById('day').style.fontWeight = 'bold';
				document.getElementById('week').style.fontWeight = 'normal';
				document.getElementById('month').style.fontWeight = 'normal';
				document.getElementById('sixMonth').style.fontWeight = 'normal';
				document.getElementById('year').style.fontWeight = 'normal';
			}
			else if (timeFrame === "week") {
				vals = <%=session.getAttribute("homeWeekData")%>;
				document.getElementById('day').style.fontWeight = 'normal';
				document.getElementById('week').style.fontWeight = 'bold';
				document.getElementById('month').style.fontWeight = 'normal';
				document.getElementById('sixMonth').style.fontWeight = 'normal';
				document.getElementById('year').style.fontWeight = 'normal';
			}
			else if (timeFrame === "month") {
				vals = <%=session.getAttribute("homeMonthData")%>;
				document.getElementById('day').style.fontWeight = 'normal';
				document.getElementById('week').style.fontWeight = 'normal';
				document.getElementById('month').style.fontWeight = 'bold';
				document.getElementById('sixMonth').style.fontWeight = 'normal';
				document.getElementById('year').style.fontWeight = 'normal';
			}
			else if (timeFrame === "sixMonth") {
				vals = <%=session.getAttribute("homeSixMonthData")%>;
				document.getElementById('day').style.fontWeight = 'normal';
				document.getElementById('week').style.fontWeight = 'normal';
				document.getElementById('month').style.fontWeight = 'normal';
				document.getElementById('sixMonth').style.fontWeight = 'bold';
				document.getElementById('year').style.fontWeight = 'normal';
			}
			else {
				vals = <%=session.getAttribute("homeYearData")%>;
				document.getElementById('day').style.fontWeight = 'normal';
				document.getElementById('week').style.fontWeight = 'normal';
				document.getElementById('month').style.fontWeight = 'normal';
				document.getElementById('sixMonth').style.fontWeight = 'normal';
				document.getElementById('year').style.fontWeight = 'bold';
			}
			
			data.addRows(vals);
			
			var options = {
				series: {
					0: { color: '#662A8E' },
					1: { color: '#90208C' },
					2: { color: '#CE0089' },
					3: { color: '#EB0080' },
					4: { color: '#EA0D2C' },
					5: { color: '#F48C37' },
					6: { color: '#FCBD3A' },
					7: { color: '#FBD542' },
					8: { color: '#A8CF4E' },
					9: { color: '#53BF48' },
					10: { color: '#06A44D' },
					11: { color: '#0FA575' },
					12: { color: '#23939F' },
					13: { color: '#2499DC' },
					14: { color: '#185AA6' },
					15: { color: '#3D2873' },
				},
				hAxis: {
					titleTextStyle: {
						italic: false 
					},
					baselineColor: 'white',
					titleColor: 'white',
					textColor: 'white',
					gridlines: {
						color: 'transparent'
					}
				},
				vAxis: {
					titleTextStyle: {
						italic: false 
					},
					baselineColor: 'white',
					title: 'PORTFOLIO VALUE',
					titleColor: 'white',
					textColor: 'white',
					gridlines: {
						color: 'transparent'
					}
				},
				backgroundColor: 'transparent',
				legend: {textStyle: {color: 'white'}},
				chartArea: {height: '80%'}
			};
			
			var chart = new google.visualization.LineChart(document.getElementById('main-chart'));
			
			chart.draw(data, options);
			var items = document.getElementsByClassName('add');

			for(var i = 0; i < items.length; i++ ) {
			    (function(i) {
			        items[i].addEventListener('click', function(event) {
			        	if (items[i].value === '-') {
			        		items[i].style.color = "green"; items[i].style.borderColor = "green";
			        		items[i].value = '+';
			        	}
			        	else {
			        		items[i].style.color = "red"; items[i].style.borderColor = "red";
			        		this.value = '-';
			        	}
			        	view = new google.visualization.DataView(data);
		        		for (var j = 0; j < items.length; j++) {
		        			if (items[j].value === '+') {
		        				view.hideColumns([j+1]);
		        			}
		        		}
		        		chart.draw(view, options);
			          
			        }, false);
			    })(i);
			}
		}

 		function changeTime(element) {
			$.ajax({
				url: "BoldServlet",
				type: "POST",
				data: {
					timeframe: element.value
				},
				success: function(result) {
					if (result === "success") {
						location.reload(true);
					}
				}
			})
 		}
		function create() {
			var portfolio = document.getElementById('port-name');
			var amnt = document.getElementById('start-amount');
			var ok = 1;
			
			console.log(portfolio.value);
			
 			if (!portfolio.value || portfolio.value === "Portfolio Name") {
				document.getElementById("no-name").className = "show";
				ok = -1;
			} else document.getElementById("no-name").className = "hide";
 			
			if (ok > 0) {
				login();	
			}
 			
			var noName = document.getElementById("no-name").className;
			
			if (noName === "hide") {
				document.getElementById("new").style.visibility = "hidden";
				createNewPortfolio(portfolio.value);
				document.getElementById('port-name').value = "Portfolio Name";
			}
		}
		
		function createNewPortfolio(port) {
			$('<li><div class="per" style="border-color: green; color: green;">0%</div><a href="PortfolioPage.jsp">' + port + '</a> <input type="button" value="+" class="add" style="border-color: green; color: green;"></li>').prependTo('#sidebar');
		}
		
 		function addSign() {
			if (document.getElementById('dollar').style.visibility === 'hidden') {
				document.getElementById('dollar').style.visibility = 'visible';
			}
			document.getElementById('start-amount').value = "";
		}
 		function addNew() {
 			if (document.getElementById('new').style.visibility === 'hidden') document.getElementById('new').style.visibility = 'visible';
 		}
 		function logout() {
 			window.location.href = "UnregisteredHomePage.jsp";
 		}
 		function friends() {
 			window.location.href = "FriendsPage.jsp";
 		}
 		function port(element) {
			$.ajax({				
				url: "SendToPort",
				type: "POST",
				data: {
					name: element.value
				},
				success: function(result) {
					if (result === "success") {
						window.location.href = "PortfolioPage.jsp";
					}
				}
			})
 		}
		</script>

				<!--  NEW PORTFOLIO ADDING TO DATABASE -->
		<script>
			function login() {
				$.ajax({
					url: "NewPortfolioServlet",
					type: "POST",
					data: {
						portfolio: document.getElementById('port-name').value
					},
					success: function(result) {
						if (result === "success") {
							window.location.href = "load.jsp";
						}
					}
				})
			}
		</script>
	</head>
	<div id="title"><i>LIL RISK INC.</i></div>
	<hr style="border: 0.5px solid white;" />
	<body>
		<input class="lr" type="button" id="logout" value="SIGN OUT" onclick="logout()">
		<input class="lr" type="button" id="friends" value="FRIENDS" onclick="friends()">
		<div id="main-chart" style="height: 85%; width: 98%; margin-left: -10%; position: relative;"></div>
		<table class="time-frames">
			<tr>
				<th><input type="button" id="day" class="time" onclick="changeTime(this)" value="1D"></th>
				<th><input type="button" id="week" class="time" onclick="changeTime(this)" value="1W"></th>
				<th><input type="button" id="month" class="time" onclick="changeTime(this)" value="1M"></th>
				<th><input type="button" id="sixMonth" class="time" onclick="changeTime(this)" value="6M"></th>
				<th><input type="button" id="year" class="time" onclick="changeTime(this)" value="1Y"></th>
			</tr>
		</table>
		<div class="form-container">
			<hr style="border: 0.5px solid white; margin-top: 12px;" />
			<ul class="sidebar" id="sidebar">
			<% String[] pn = null;
				
				if (timeFrame.equals("day")) pn = (String[])(session.getAttribute("homePnDay"));
				else if (timeFrame.equals("week")) pn = (String[])(session.getAttribute("homePnWeek"));
				else if (timeFrame.equals("month")) pn = (String[])(session.getAttribute("homePnMonth"));
				else if (timeFrame.equals("sixMonth")) pn = (String[])(session.getAttribute("homePnSixMonth"));
				else pn = (String[])(session.getAttribute("homePnYear"));
			
				String color = "";
				int cnt = 0;
				for (int i = 0; i < syms.length - 1; i+=2) {
					if (pn[cnt] == "n") {
						color = "red";
					}
					else {
						color = "green";
					}
					cnt++;
			%>
 				<li><div class="per" style="border-color: <%=color%>; color: <%=color%>;"><%=syms[i+1] %></div><input type="button" class="none" onclick="port(this)" value="<%=syms[i] %>"><input type="button" value="-" class="add"></li>
 			<%} %>
				<li>New Portfolio<input type="button" value="+" class="addNew" onclick="addNew()" style="border-color: purple; color: purple;"></li>
			</ul>
		</div>
		<!-- add a new portfolio -->
		<div class="center" id="new" style="visibility: hidden;">
			<ul class="new-portfolio">
				<li style="color: white; font-size: 30px; padding-top: 50px; padding-bottom: 10px;">New Portfolio</li>
				<li><input type="text" id="port-name" onfocus="this.value=''" value="Portfolio Name"></li></br>
				<li><input type="button" class="create" onclick="create()" name="create" value="Create"></li>
			</ul>
		</div>
		<div class="top" id="alert">
			<ul class="alert">
				<li id="no-name" class="hide">Must have a portfolio name.</li>
			</ul>
		</div>
	</body>
</html>
