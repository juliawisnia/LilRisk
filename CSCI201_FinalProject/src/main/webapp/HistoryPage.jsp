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
	overflow-y: auto;
	border-left: 1px solid white;
	padding: 100px 0px;
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

ul.StockSideBar {
	width: 100%;
	list-style-type: none;
	padding: 0;
	border-bottom: white;
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
#search {
	background-color: rgba(0,0,0,0);
	color: white;
	font-size: 25px;
	width: 90%;
	padding-left: 10px;
	padding-top: 5px; padding-bottom: 5px;
	margin-bottom: 10px;
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

/* HISTORY BUTTON	 */
#historyButton {
	background-color: #313030;
	border: 1px solid white;
	border-radius: 20px;
	color: white;
	padding-right: 20px;
	padding-left: 20px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 22px;
	margin: 2px 2px;
	cursor: pointer;
	z-index: 4; 
	position: absolute;
	top: 200px;
	left: 1000px;
	font-family: Avenir Next; 
}

/* MAIN GRAPH */
#mainGraph{
	z-index: 4; 
	position: absolute;
	width: 80%; 
	height: 450px;
	top: 150px;
	left: 0px;
}

.stocks-container {
	max-height: 400px;
	overflow-y: scroll;
	margin-left: 5%;
	margin-top: 30%;
}

.stocks {
	text-align: center;
	border-collapse: collapse;
	color: white;
	width: 75%;
}

.stocks td, .stocks th {
	border: 1px solid #ddd;
	padding: 8px;
}

.stocks th {
	padding-top: 12px;
	padding-bottom: 12px;
	color: white;
}

.stocks tr:last-child {
	border: none;
}

.sb {
	text-transform: uppercase;
	border: none;
	color: white;
	font-size: 30px;
	background-color: rgba(0,0,0,0);
	padding: 0;
	cursor: pointer;
}</style>
		<link rel="stylesheet" type="text/css" href="HistoryPage.css" />
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<!-- MAIN GRAPH -->
		<script type="text/javascript">
		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(drawChart);
		
		function drawChart() {
		  var data = google.visualization.arrayToDataTable([
		    ['MONTH', 'PORTFOLIO', 'APPL'],
		    ['JAN',     1000,       246  ],
		    ['FEB',     1170,       443  ],
		    ['MAR',     660,        376  ],
		    ['APR',     700,        534  ],
		    ['MAY',     532,        122  ],
		    ['JUN',     656,        531  ],
		    ['JUL',     563,        321  ],
		    ['AUG',     995,        525  ],
		    ['SEP',     900,        426  ],
		    ['OCT',     1035,       901  ],
		    ['NOV',     621,        313  ],
		    ['DEC',     732,        522  ]
		  ]);
		
		  var options = {
		    vAxis: {minValue: 0},
		    
		    colors:['#0077D7', '#E9005E', '#FFBA01', '#03CC6B', '#FF4343', '#C139B2', '#00B7C5'],
		  
		    legend: {
				position: 'labeled',
				textStyle: {
					color: 'white', 
					fontSize: 16
					},
			},
		  
			fontSize: 20,
	        fontName: 'Avenir Next',
	        backgroundColor: '#242424',
		  
	        hAxis: {
	        	baselineColor: 'white',
	        	gridlines: {
	        		color: 'transparent',
	        	},
	        	textStyle: {
					color: 'white',
					fontName: 'Avenir Next',
					fontSize: 12,
					bold: false,
					italic: false,
	        	},
	        },
	        
	        vAxis: {
	        	baseline: 0,
	        	baselineColor: 'white',
	        	gridlines: {
	        		color: 'transparent',
	        	},
	        	textStyle: {
					color: 'white',
					fontName: 'Avenir Next',
					fontSize: 15,
					bold: false,
					italic: false,
	        	},
	        },
		  
	        lineWidth: 4,
		  
		  };
		
		  var chart = new google.visualization.LineChart(document.getElementById('mainGraph'));
		  chart.draw(data, options);
		}
		</script>
		
		
		<meta charset="UTF-8">
		<title>Lil Risk</title>
		<link rel="stylesheet" type="text/css" href="HistoryPage.css" />
	</head>
	<body id="body">
		
	<div id="title"><i><a href="home.jsp">LIL RISK INC.</a></i></div>
	<hr style="border: 0.5px solid white;" />
	<body>
		<div class="portfolio-name">PORTFOLIO NAME</div>
		<div class="form-container">
			<hr style="border: 0.5px solid white; margin-top: 12px;" />
			<ul class="PortfolioSideBar" id="PortfolioSideBar">
				<li><a href="PortfolioPage.jsp">Portfolio 1 </a><div class="per">2.5%</div></li>
				<li><a href="PortfolioPage.jsp">Portfolio 2 </a><div class="per" style="border-color: green; color: green;">2.45%</div></li>
				<li><a href="PortfolioPage.jsp">Agressive </a><div class="per" style="border-color: green; color: green;">3.54%</div></li>
				<li><a href="PortfolioPage.jsp">Careful </a><div class="per">2.18%</div></li>
				<li><a href="PortfolioPage.jsp">Tech </a><div class="per" style="border-color: green; color: green;">8.81%</div></li>
			</ul>
		</div>		
		<!-- MAIN GRAPH-->		
		<div id="mainGraph" style="position: fixed; z-index: 1;"></div>
		
		<div class="stocks-container">
			<table class="stocks">
				<tr>
					<th>Symbol</th>
					<th>Purhcase Price</th>
					<th>Price Sold</th>
					<th>Total gain/loss</th>
					<th>Quantity</th>
				</tr>
				<tr>
					<td>AAPL</td>
					<td>$167.88</td>
					<td>$102.38</td>
					<td>$1000</td>
					<td>50</td>
				</tr>
				<tr>
					<td>GOOG</td>
					<td>$1128.88</td>
					<td>$102.38</td>
					<td>$1000</td>
					<td>50</td>
				</tr>
				<tr>
					<td>FB</td>
					<td>$182.88</td>
					<td>$102.38</td>
					<td>$1000</td>
					<td>50</td>
				</tr>
				<tr>
					<td>TWTR</td>
					<td>$67.18</td>
					<td>$102.38</td>
					<td>$1000</td>
					<td>50</td>
				</tr>
				<tr>
					<td>SNAP</td>
					<td>$13.29</td>
					<td>$102.38</td>
					<td>$1000</td>
					<td>50</td>
				</tr>
				<tr>
					<th>Total</th>
					<th></th>
					<th>13.46%</th>
					<th>$5000</th>
					<th></th>
				</tr>
			</table>
		</div>
	</body>
</html>