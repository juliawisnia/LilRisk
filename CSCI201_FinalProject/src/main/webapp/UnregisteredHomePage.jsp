<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true"%>
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

html,body {
	height: 100%;
	max-width: 100%;
	overflow-y: hidden;
}

.form-container {
	margin-top: 6.75%;
	height: 90%;
	width: 320px; 	
	position: fixed;
	z-index: 1;
	top: 0;
	right: 0;
	background-color: #313030;
	overflow-x: hidden;
	overflow-y: auto;
	border-left: 1px solid white;
}

.top-box {
	position: fixed;
	top: 0; right: 0;
	border-left: 1px solid white;
	background-color: #313030;
	width: 320px;
	margin-top: 0px;
	height: 10.65%;
	z-index: 4;
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

input[type=button].add, input[type=button].lr {
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

input {
	border-radius: 10px;
	border-style: solid white;
	border-width: 1px;
	font-size: 30px;
	color: #E0E0E0;
	padding: 10px 17px;
	background-color: rgb(189, 189, 189, .2);
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

/*LOGIN/REGISTER BUTTONS*/	
#loginButton {
	position: absolute;
	background-color: #313030;
	border: 1px solid white;
	border-radius: 20px;
	color: white;
	padding-right: 80px;
	padding-left: 35px;
	text-align: center;
	font-size: 15px;
	cursor: pointer;
	z-index: 5;
	top: 4%; right: 9.5%;
}

#registerButton {
	position: absolute;
	background-color: #313030;
	border: 1px solid white;
	color: white;
	border-radius: 60px;
	padding-right: 90px;
	padding-left: 20px;
	text-align: center;
	font-size: 15px;
	cursor: pointer;
	z-index: 5;
	top: 4%; right: 2%;
}
		</style>
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
		<script type="text/javascript">
		function load() {
			console.log("here");
		}
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
				System.out.println(timeFrame);
				String[] syms = null;
				if (timeFrame.equals("day")) syms = (String[])(session.getAttribute("dayVals"));
				else if (timeFrame.equals("week")) syms = (String[])(session.getAttribute("weekVals"));
				else if (timeFrame.equals("month")) syms = (String[])(session.getAttribute("monthVals"));
				else if (timeFrame.equals("sixMonth")) syms = (String[])(session.getAttribute("sixMonthVals"));
				else syms = (String[])(session.getAttribute("yearVals"));
				
				String sym = "";
				for (int i = 0; i < syms.length - 1; i+=2) {
					sym = syms[i];
			%>
			data.addColumn('number', '<%=sym %>');
			<%}%>
			
			var vals; 
			var timeFrame = "<%= session.getAttribute("timeFrame")%>";
			console.log(timeFrame);
			if (timeFrame === "day") vals = <%=session.getAttribute("dayData")%>;
			else if (timeFrame === "week") vals = <%=session.getAttribute("weekData")%>;
			else if (timeFrame === "month") vals = <%=session.getAttribute("monthData")%>;
			else if (timeFrame === "sixMonth") vals = <%=session.getAttribute("sixMonthData")%>;
			else vals = <%=session.getAttribute("yearData")%>;
			
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
					title: 'COIN VALUE',
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
		function create() {
			var portfolio = document.getElementById('port-name');
			var amnt = document.getElementById('start-amount');
			
 			if (!portfolio.value || portfolio.value === "Portfolio Name") {
				document.getElementById("no-name").className = "show";
			} else document.getElementById("no-name").className = "hide";
 			
			var noName = document.getElementById("no-name").className;
			
			if (noName === "hide") {
				document.getElementById("new").style.visibility = "hidden";
				createNewPortfolio(portfolio.value);
				document.getElementById('port-name').value = "Portfolio Name";
			}
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
 		function day() {
 			console.log("day");
 			<%session.setAttribute("timeFrame", "day");%>
 			location.reload(true);
 		}
 		function week() {
 			console.log("week");
			<%session.setAttribute("timeFrame", "week");%>
			location.reload(true);
 		}
 		function month() {
 			console.log("month");
			<%session.setAttribute("timeFrame", "month");%>
			location.reload(true);
 		}
 		function smonth() {
 			console.log("sixmonth");
			<%session.setAttribute("timeFrame", "sixMonth");%>
			location.reload(true);
 		}
 		function year() {
 			console.log("year");
 			<%session.setAttribute("timeFrame", "year");%>
			location.reload(true);
 		}
		</script>
		
	</head>
	<a href="UnregisteredHomePage.jsp" style="text-decoration: none;"><div id="title"><i>LIL RISK</i></div></a>
	<hr style="border: 0.5px solid white;" />
	<body>
		
		<!-- LOGIN/REGISTER BUTTONS -->
		<a href="LoginPage.jsp"><input class="lr" type="button" id="loginButton" value="LOGIN"></a>
		<a href="RegisterPage.jsp"><input class="lr" type="button" id="registerButton" value="REGISTER"></a>		
		
		<div id="main-chart" style="height: 85%; width: 98%; margin-left: -10%; position: relative;"></div>
		<table class="time-frames">
			<tr>
				<th><input type="button" class="time" onclick="day()" value="1D" style="font-weight: bold;"></th>
				<th><input type="button" class="time" onclick="week()" value="1W"></th>
				<th><input type="button" class="time" onclick="month()" value="1M"></th>
				<th><input type="button" class="time" onclick="smonth()" value="6M"></th>
				<th><input type="button" class="time" onclick="year()" value="1Y"></th>
			</tr>
		</table>
		<div class="top-box"></div>
		<div class="form-container">
			<ul class="sidebar" id="sidebar">
			<% 
				String[] pn = null;
				
				if (timeFrame.equals("day")) pn = (String[])(session.getAttribute("pnDay"));
				else if (timeFrame.equals("week")) pn = (String[])(session.getAttribute("pnWeek"));
				else if (timeFrame.equals("month")) pn = (String[])(session.getAttribute("pnMonth"));
				else if (timeFrame.equals("sixMonth")) pn = (String[])(session.getAttribute("pnSixMonth"));
				else pn = (String[])(session.getAttribute("pnYear"));
			
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
 				<li><div class="per" style="border-color: <%=color%>; color: <%=color%>;"><%=syms[i+1] %></div><%=syms[i] %><input type="button" value="-" class="add"></li>
 			<%} %>
			</ul>
		</div>
	</body>
</html>