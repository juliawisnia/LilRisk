<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Home</title>
		<link rel="stylesheet" type="text/css" href="unregistered.css" />
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
		<script>
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
			data.addColumn('number', 'PORTFOLIO 1');
			data.addColumn('number', 'PORTFOLIO 2');
			data.addColumn('number', 'PORTFOLIO 3');
			
			data.addRows([
				[0, 0, 0, 1],    [1, 10, 5, 2],   [2, 23, 15, 3],  [3, 17, 9, 4],   [4, 18, 10, 5],  [5, 9, 5, 6],
				[6, 11, 3, 7],   [7, 27, 19, 8],  [8, 33, 25, 9],  [9, 40, 32, 10],  [10, 32, 24, 11], [11, 35, 27, 12],
				[12, 30, 22, 13], [13, 40, 32, 14], [14, 42, 34, 14], [15, 47, 39, 16], [16, 44, 36, 17], [17, 48, 40, 18],
				[18, 52, 44, 19], [19, 54, 46, 20], [20, 42, 34, 21], [21, 55, 47, 22], [22, 56, 48, 23], [23, 57, 49, 24],
				[24, 60, 52, 25], [25, 50, 42, 26], [26, 52, 44, 27], [27, 51, 43, 28], [28, 49, 41, 29], [29, 53, 45, 30],
				[30, 55, 47, 31], [31, 60, 52, 32], [32, 61, 53, 33], [33, 59, 51, 34], [34, 62, 54, 35], [35, 65, 57, 36],
				[36, 62, 54, 37], [37, 58, 50, 38], [38, 55, 47, 39], [39, 61, 53, 40], [40, 64, 56, 41], [41, 65, 57, 42],
				[42, 63, 55, 43], [43, 66, 58, 44], [44, 67, 59, 45], [45, 69, 61, 46], [46, 69, 61, 47], [47, 70, 62, 48],
				[48, 72, 64, 49], [49, 68, 60, 50], [50, 66, 58, 51], [51, 65, 57, 52], [52, 67, 59, 53], [53, 70, 62, 54],
				[54, 71, 63, 55], [55, 72, 64, 56], [56, 73, 65, 57], [57, 75, 67, 58], [58, 70, 62, 59], [59, 68, 60, 60],
				[60, 64, 56, 61], [61, 60, 52, 62], [62, 65, 57, 63], [63, 67, 59, 64], [64, 68, 60, 65], [65, 69, 61, 66],
				[66, 70, 62, 67], [67, 72, 64, 68], [68, 75, 67, 69], [69, 80, 72, 70]
			]);
			
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
		
		function random_rgba() {
		    var o = Math.round, r = Math.random, s = 255;
		    return 'rgba(' + o(r()*s) + ',' + o(r()*s) + ',' + o(r()*s)+ ')';
		}
		
		function createNewPortfolio(port) {
			var color = '#'+Math.floor(Math.random()*16777215).toString(16);
			$('<li><div class="per"style="border-color: green; color: green;">0%</div><a href="PortfolioPage.jsp">' + port + '</a> <input type="button" value="+" class="add" style="border-color:' + color + '; color:' + color +  ';"></li>').prependTo('#sidebar');
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
		</script>
	</head>
	<a href="UnregisteredHomePage.jsp" style="text-decoration: none"><div id="title"><i>LIL RISK</i></div></a>
	<hr style="border: 0.5px solid white;" />
	<body>
		
		<!-- LOGIN/REGISTER BUTTONS -->
		<a href="LoginPage.jsp"><input type="button" id="loginButton" value="LOGIN"></a>
		<a href="RegisterPage.jsp"><input type="button" id="registerButton" value="REGISTER"></a>		
		
		<div id="main-chart" style="height: 90%; width: 95%; margin-left: -10%; position: relative;"></div>
		<div class="form-container">
			<hr style="border: 0.5px solid white; margin-top: 12px;" />
			<ul class="sidebar" id="sidebar">
				<li><div class="per">2.5%</div><a href="PortfolioPage.jsp">Dow Jones </a><input type="button" value="-" class="add" id="1"></li>
				<li><div class="per" style="border-color: green; color: green;">3.8%</div><a href="PortfolioPage.jsp">S&P 500 </a><input type="button" value="-" class="add" style="border-color: green; color: green;"></li>
				<li><div class="per" style="border-color: green; color: green;">1.8%</div><a href="PortfolioPage.jsp">NASDAQ </a><input type="button" value="-" class="add" style="border-color: blue; color: blue;"></li>
			</ul>
		</div>
		<!-- add a new portfolio -->
		<div class="center" id="new" style="visibility: hidden;">
			<ul class="new-portfolio">
				<li style="color: white; font-size: 30px; padding-top: 50px; padding-bottom: 10px;">New Portfolio</li>
				<li><input type="text" id="port-name" onfocus="this.value=''" value="Portfolio Name"></li></br>
				<li><input type="button" onclick="create()" name="create" value="Create"></li>
			</ul>
		</div>
		<div class="top" id="alert">
			<ul class="alert">
				<li id="no-name" class="hide">Must have a portfolio name.</li>
			</ul>
		</div>
	</body>
</html>