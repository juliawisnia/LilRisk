<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
			<!-- SIDEBAR SCRIPT -->
			<script> 
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
	<input type="button" id="stocksButton" value="STOCKS" onclick= "changeSideBar()">
	<input type="button" id="portfolioButton" value="PORTFOLIOS" onclick= "changeSideBar()">
	<hr style="border: 0.5px solid white;" />
	<body>
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
				<li class="symbol" style="border-top: 1px solid white;">AAPL<div class="price">190.50</div></li>
				<li class="company">Apple Inc. <div class="portPer">0.60%</div></li>
				<li class="symbol">GOOG<div class="price">1,197.25</div></li>
				<li class="company">Alphabet Inc.<div class="portPer">0.65%</div></li>
				<li class="symbol">fb<div class="price">177.58</div></li>
				<li class="company">Facebook, Inc.<div class="portPer" style="border-color: green; color: green;">2.65%</div></li>
			</ul>
		</div>		
		<!-- MAIN GRAPH-->		
		<div id="mainGraph"></div>
		
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