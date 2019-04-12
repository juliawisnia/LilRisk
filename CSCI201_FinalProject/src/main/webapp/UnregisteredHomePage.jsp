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
			data.addColumn('number', 'X');
			data.addColumn('number', '<%=session.getAttribute("firstSym")%>');
			data.addColumn('number', '<%=session.getAttribute("secondSym")%>');
			data.addColumn('number', '<%=session.getAttribute("thirdSym")%>');
			var vals = <%= session.getAttribute("data")%>;
			data.addRows(vals);
			
			var options = {
				series: {
					0: { color: '#e2431e' },
					1: { color: '#e7711b' },
					2: { color: '#f1ca3a' },
					3: { color: '#6f9654' },
					4: { color: '#1c91c0' },
					5: { color: '#43459d' },
				},
				hAxis: {
					title: 'Month',
					gridlines: {
						color: 'transparent'
					}
				},
				vAxis: {
					title: 'Account Value',
					/* textStyle:{color: 'white'}, */
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
			        		items[i].value = '+';
			        	}
			        	else {
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
 		window.onload = load();
		</script>
	</head>
	<a href="UnregisteredHomePage.jsp" style="text-decoration: none;"><div id="title"><i>LIL RISK</i></div></a>
	<hr style="border: 0.5px solid white;" />
	<body>
		
		<!-- LOGIN/REGISTER BUTTONS -->
		<a href="LoginPage.jsp"><input type="button" id="loginButton" value="LOGIN"></a>
		<a href="RegisterPage.jsp"><input type="button" id="registerButton" value="REGISTER"></a>		
		
		<div id="main-chart" style="height: 90%; width: 95%; margin-left: -10%; position: relative;"></div>
		<div class="form-container">
			<hr style="border: 0.5px solid white; margin-top: 12px;" />
			<ul class="sidebar" id="sidebar">
				<li><div class="per"><%=(String)session.getAttribute("firstChange") %></div><%=(String)session.getAttribute("firstSym") %><input type="button" value="-" class="add" id="1"></li>
				<li><div class="per"><%=(String)session.getAttribute("secondChange") %></div><%=(String)session.getAttribute("secondSym") %><input type="button" value="-" class="add" style="border-color: green; color: green;"></li>
				<li><div class="per"><%=(String)session.getAttribute("thirdChange") %></div><%=(String)session.getAttribute("thirdSym") %><input type="button" value="-" class="add" style="border-color: blue; color: blue;"></li>
			</ul>
		</div>
	</body>
</html>