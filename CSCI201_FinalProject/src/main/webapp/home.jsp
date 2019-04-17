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

input[type=button] {
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

ul.new-portfolio input[type=button] {
	cursor: pointer;
	font-size: 30px;
	width: 155px;
	height: 44px;
	background-color: #084179;
	color: #E0E0E0;
	border-radius: 15px;
	border-style: solid white;
	border-width: 1px;
	border-color: white;
	margin-right: 31%;
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

		</style>
		<link rel="stylesheet" type="text/css" href="home.css" />
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
			$('<li><div class="per" style="border-color: green; color: green;">0%</div><a href="PortfolioPage.jsp">' + port + '</a> <input type="button" value="+" class="add" style="border-color:' + color + '; color:' + color +  ';"></li>').prependTo('#sidebar');
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
	<div id="title"><i>LIL RISK INC.</i></div>
	<hr style="border: 0.5px solid white;" />
	<body>
		<div id="main-chart" style="height: 90%; width: 95%; margin-left: -10%; position: relative;"></div>
		<div class="form-container">
			<hr style="border: 0.5px solid white; margin-top: 12px;" />
			<ul class="sidebar" id="sidebar">
				<li><div class="per">2.5%</div><a href="PortfolioPage.jsp">Portfolio 1 </a><input type="button" value="-" class="add" id="1"></li>
				<li><div class="per" style="border-color: green; color: green;">3.8%</div><a href="PortfolioPage.jsp">Portfolio 2 </a><input type="button" value="-" class="add" style="border-color: green; color: green;"></li>
				<li><div class="per" style="border-color: green; color: green;">1.8%</div><a href="PortfolioPage.jsp">Portfolio 3 </a><input type="button" value="-" class="add" style="border-color: blue; color: blue;"></li>
				<li>New Portfolio<input type="button" value="+" id="add" onclick="addNew()" style="border-color: purple; color: purple;"></li>
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