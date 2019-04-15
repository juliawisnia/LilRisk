<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Home</title>
		<link rel="stylesheet" type="text/css" href="unregistered.css" />
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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
			
			var options = document.getElementsByClassName('time');
			var timeFrame;
			for (var i = 0; i < options.length; i++) {
				if (options[i].style.fontWeight === "bold") timeFrame = options[i].value;
			}
			
			if (timeFrame === '1D') timeFrame = "day";
			else if (timeFrame === '1W') timeFrame = "week";
			else if (timeFrame === '1M') timeFrame = "month";
			else if (timeFrame === '6M') timeFrame = "sixMonth";
			else timeFrame = "year";
			
			data.addColumn('number', 'X');
			<%
				String timeFrame = (String)(session.getAttribute("timeFrame"));
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
			if (timeFrame.equals("day")) <%= session.getAttribute("dayData")%>;
			else if (timeFrame.equals("week")) <%= session.getAttribute("weekData")%>;
			else if (timeFrame.equals("month")) <%= session.getAttribute("monthData")%>;
			else if (timeFrame.equals("sixMonth")) <%= session.getAttribute("sixMonthData")%>;
			else syms = <%= session.getAttribute("yearData")%>;
			
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
						fontName: 'Avenir Next',
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
						fontName: 'Avenir Next',
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
 		function bold(element) {
 			location.reload();
 			var all = document.getElementsByClassName('time');
 			for (var i = 0; i < all.length; i++) {
 				if (all[i].isSameNode(element)) {
 					all[i].style.fontWeight = "bold";
 				}
 				else {
 					all[i].style.fontWeight = "normal";
 				}
 			}
 			
 		}
 		window.onload = load();
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
				<th><input type="button" class="time" onclick="bold(this)" value="1D" style="font-weight: bold;"></th>
				<th><input type="button" class="time" onclick="bold(this)" value="1W"></th>
				<th><input type="button" class="time" onclick="bold(this)" value="1M"></th>
				<th><input type="button" class="time" onclick="bold(this)" value="6M"></th>
				<th><input type="button" class="time" onclick="bold(this)" value="1Y"></th>
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