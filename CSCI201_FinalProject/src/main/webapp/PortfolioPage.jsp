<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<!-- SIDEBAR SCRIPT -->
		<script> 
			function buy(symbol) {
				
			}
			function changeSideBar() {
				if (document.getElementById('PortfolioSideBar').style.display === 'none') {
					document.getElementById('stocksButton').style.backgroundColor = '#313030';
					document.getElementById('portfolioButton').style.backgroundColor = '#7d7d7d';
					document.getElementById('PortfolioSideBar').style.display = 'inline';
					document.getElementById('StockSideBar').style.display = 'none';
				}
				else {
					document.getElementById('stocksButton').style.backgroundColor = '#7d7d7d';
					document.getElementById('portfolioButton').style.backgroundColor = '#313030';
					document.getElementById('PortfolioSideBar').style.display = 'none';
					document.getElementById('StockSideBar').style.display = 'inline';
				}
			}

		</script>
		<!-- DONUT CHART SCRIPT -->
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<script type="text/javascript">
		// Load google charts
		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(drawChart);
		
		// Draw the chart and set the chart values
		function drawChart() {
		  var data = google.visualization.arrayToDataTable([
		  ['Stocks', 'Shares'],
		  ['APPL', 50],
		  ['GOOG', 50],
		  ['FB', 50],
		  ['TWTR', 50],
		  ['SNAP', 50]
		]);
		
		  // Optional; add a title and set the width and height of the chart
		  var options = {
				title:'STOCKS IN PORTFOLIO',
				legend: {
					position: 'labeled',
					textStyle: {
						color: 'white', 
						fontSize: 16
						},
				},
				//legend: 'none',
				pieHole: 0.5,
				pieSliceTextStyle: {
		            color: 'white',
		            font: 'Avenir Next',
		            size: 30,
		        },
		        pieSliceBorderColor: '#242424',
		        pieSliceText: 'none',
		        
		        fontSize: 20,
		        fontName: 'Avenir Next',
		        //is3D: true,
		        
		        backgroundColor: '#242424',
		        
		        chartArea: {
		        	width:'95%',
		        	height:'75%',
		        },
		        
		        titleTextStyle: {
		        	color: 'white',
					fontName: 'Avenir Next',
					fontSize: 20,
					bold: false,
		        },
		        
		        colors:['#FFBA01', '#E9005E', '#03CC6B', '#0077D7', '#FF4343', '#C139B2', '#00B7C5'],
			};
		
		  // Display the chart inside the <div> element with id="piechart"
		  var chart = new google.visualization.PieChart(document.getElementById('donutChart'));
		  chart.draw(data, options);
		}
		</script>
		
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
	        backgroundColor: { fill: 'transparent' },
		  
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
		<link rel="stylesheet" type="text/css" href="PortfolioPage.css" />
	</head>
	<body id="body">
		
	<div id="title"><i><a href="home.jsp">LIL RISK INC.</a></i></div>
	<input type="button" id="stocksButton" value="STOCKS" onclick= "changeSideBar()">
	<input type="button" id="portfolioButton" value="PORTFOLIOS" onclick= "changeSideBar()">
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
			<ul class="StockSideBar" id="StockSideBar" style="display: none;">
				<li id="look"><input type="text" id="search" value="Search" onfocus="this.value=''"></li>
				
				<li class="symbol" style="border-top: 1px solid white;"><input type="button" class="sb" value="AAPL" onclick="buy(this.value)"><div class="price" onclick="expand()">190.50</div></li>
				<li class="company">Apple Inc. <div class="portPer">0.60%</div></li>
				
				<li class="symbol"><input type="button" class="sb" value="GOOG"><div class="price">1,197.25</div></li>
				<li class="company">Alphabet Inc.<div class="portPer">0.65%</div></li>
				
				<li class="symbol"><input type="button" class="sb" value="FB"><div class="price">177.58</div></li>
				<li class="company">Facebook, Inc.<div class="portPer" style="border-color: green; color: green;">2.65%</div></li>
			</ul>
		</div>
<!-- 		<div class="center" id="new" style="visibility: inline;">
			<ul class="buy-shares">
				<li style="color: white; font-size: 30px; padding-top: 50px; padding-bottom: 10px;">Buy</li>
				<li><input type="text" id="shares"></li></br>
				<li><input type="button" onclick="create()" name="create" value="Create"></li>
			</ul>
		</div>
		<div class="top" id="alert">
			<ul class="alert">
				<li id="no-name" class="hide">Must have a portfolio name.</li>
			</ul>
		</div> -->

 		<!-- HISTORY BUTTON -->
		<a href="HistoryPage.jsp"><input type="button" id="historyButton" value="HISTORY"></a>

		<!-- DONUT CHART -->		
		<div id="donutChart" ></div>
		
		<!-- MAIN GRAPH-->		
		<div id="mainGraph" style="position: fixed; z-index: 1;"></div>
		
		<div class="stocks-container">
			<table class="stocks">
				<tr>
					<th>Symbol</th>
					<th>Last Price</th>
					<th>Today's gains/losses</th>
					<th>Current Value</th>
					<th>Quantity</th>
				</tr>
				<tr>
					<td>AAPL</td>
					<td>$167.88</td>
					<td>3.29%</td>
					<td>$1000</td>
					<td>50</td>
				</tr>
				<tr>
					<td>GOOG</td>
					<td>$1128.88</td>
					<td>4.87%</td>
					<td>$1000</td>
					<td>50</td>
				</tr>
				<tr>
					<td>FB</td>
					<td>$182.88</td>
					<td style="color: red;">9.87%</td>
					<td>$1000</td>
					<td>50</td>
				</tr>
				<tr>
					<td>TWTR</td>
					<td>$67.18</td>
					<td>12.2%</td>
					<td>$1000</td>
					<td>50</td>
				</tr>
				<tr>
					<td>SNAP</td>
					<td>$13.29</td>
					<td style="color: red;">4.87%</td>
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