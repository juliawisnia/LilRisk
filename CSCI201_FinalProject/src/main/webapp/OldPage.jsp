<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<style>
	#body{
		background-color: #242424;
		position: absolute;
		z-index: 1;
	}
	
	#LogoHeader{
		font-family: Avenir Next; 
		font-size: 70px; 
		font-style: italic;
		top: 5px;
		left: 6px;
	}
	/*PORTFOLIO HEADER*/	
	#PageHeader {
		border: 1px solid white;
		text-align: left; 
		font-family: Avenir Next; 
		width: 1905px; 
		color: white; 
		z-index: 2; 
		position: absolute;
		font-weight: lighter;
		height: 110px;
	}
	#PageHeader td {
	    border-left: 1px solid white;
	}
	#PageHeader td:first-child {
		border-left:none;
	}
	#PortfolioName{
		font-family: Avenir Next;
		background-color: #242424;
		color: white;
		font-size: 45px;
		font-style: italic;
		font-weight: 300;
		width: 1619px;
	}
	#ProfileName{
		font-family: Avenir Next;
		background-color: #313030;
		color: white;
		font-size: 20px;
		font-weight: 300;
		width: 289px;
	}
	
	/*SIDE BAR*/	
	#PortfolioSideBar{
		top: 205px;
		left: 1613px;
		border: 1px solid white;
		background-color: #313030;
		text-align: left; 
		font-size: 30px; 
		font-family: Avenir Next; 
		width: 290px; 
		color: white; 
		z-index: 2; 
		position: absolute;
		font-weight: lighter;
		height: 850px;
	}
	#PortfolioSideBar td {
	    border-bottom: 1px solid white;
	}
	#PortfolioSideBar tr:last-child td{
		border-bottom:none;
	}
	
	/* PORTFOLIO VALUES */
	#portfolioValue {
		background-color: #313030;
		border: 1px solid white;
		border-radius: 10px;
		text-align: center;
		text-decoration: none;
		font-size: 15px;
		width: 60px;
		color: white; 
		font-family: Avenir Next;
	}
	#StockSideBar{
		top: 205px;
		left: 1613px;
		border: 1px solid white;
		background-color: #313030;
		text-align: left; 
		font-size: 30px; 
		font-family: Avenir Next; 
		width: 290px; 
		color: white; 
		z-index: 2; 
		position: absolute;
		font-weight: lighter;
		height: 850px;
	}
	#StockSideBar td {
	    border-bottom: 1px solid white;
	}
	#StockSideBar tr:last-child td{
		border-bottom:none;
	}
	
	#stockFullName{
		font-size: 15px; 
		font-family: Avenir Next; 
		color: white; 
		font-weight: lighter;
		margin-top: -5px;
		margin-bottom: 2px;
	}
	
	#SearchBar{
		background: white;
		border: 1px solid lightgrey; 
		width: 150px; 
		font-size: 20px; 
		font-style: italic; 
		color: black; 
		height: 30px; 
		padding: 3px; 
		padding-right: 37px;
		padding-left: 3px;
		text-align: left; 
		font-family: Avenir Next; 
		margin: 5px;
	}
	
	/*SIDEBAR BUTTONS*/	
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
		top: 180px;
		left: 1770px;
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
		top: 180px;
		left: 1660px;
	}
	/*HISTORY BUTTON*/	
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
		top: 230px;
		left: 1400px;
		font-family: Avenir Next; 
	}
	
	/*MAIN GRAPH*/
	#mainGraph{
		z-index: 4; 
		position: absolute;
		width: 1000px; 
		height: 370px;
		top: 265px;
	}
	
	/*DONUT CHART*/
	#donutChart{
		z-index: 4; 
		position: absolute;
		width: 500px; 
		height: 400px;
		top: 280px; 
		left: 1000px;
	}
	
	/*CURRENT STOCKS TABLE*/
	#CurrentStocks tr:last-child td{
		border-bottom:none;
	}
	#CurrentStocks td {
	    border-left: 1px solid white;
	    border-bottom: 1px solid white;
	}
	#CurrentStocks td:first-child {
	    border-left: none;
	}
	#CurrentStocks td {
	    width: 200px;
	}
	#CurrentStocks {
		top: 740px;
		left: 20px;
		border: 1px solid white;
		background-color: #242424;
		font-size: 20px; 
		font-family: Avenir Next; 
		font-weight: 200;
		width: 1550px; 
		height: 100px;
		color: white; 
		z-index: 2; 
		position: absolute;
		table-layout: fixed ;
		overflow: auto; 
		overflow-x: hidden;
	}
	</style>
	
	<head>
		<!-- SIDEBAR SCRIPT -->
		<script> 
			function onload(){
				document.getElementById("StockSideBar").style.display = "none";
			}
			function loadPortfolios(){
				document.getElementById("StockSideBar").style.display = "none";
				document.getElementById("PortfolioSideBar").style.display = "inline";
				document.getElementById("stocksButton").style.backgroundColor = "#313030"
				document.getElementById("portfolioButton").style.backgroundColor = "#7d7d7d"
			}
			function loadStocks(){
				document.getElementById("StockSideBar").style.display = "inline";
				document.getElementById("PortfolioSideBar").style.display = "none";
				document.getElementById("stocksButton").style.backgroundColor = "#7d7d7d"
					document.getElementById("portfolioButton").style.backgroundColor = "#313030"
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
	        backgroundColor: '#242424',
		  
	        chartArea: {
	        	left: 79,
	        	width:'79%',
	        	height:'80%',
	        },
	        
	        hAxis: {
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
	</head>
	<body id="body" onload= "onload()">
		
		<!-- LIL RISK LOGO -->		
		<div id= "LogoHeader">
			<a href="http://localhost:8080/CSCI-201-FinalProject-LilRisk/HomePage.jsp" style="text-decoration: none; color: white;">LIL RISK INC.</a>
		</div>
		
		<!--  PORTFOLIO HEADER -->
		<table id= "PageHeader">
			<tr>
				<td id="PortfolioName">PORTFOLIO 1</td>
				<td id="ProfileName"> Good Morning Jeffery Miller, PhD! </td>
			</tr>
		</table>

		<!-- PORTFOLIO SIDEBAR -->
		<table id= "PortfolioSideBar">
			<tr>
				<td><a href="http://localhost:8080/CSCI-201-FinalProject-LilRisk/PortfolioPage.jsp" style="text-decoration: none; color: white;">PORTFOLIO 1</a></td>
				<td style="width: 80px"><input type="button" value="2.57%" id="portfolioValue"></td>
			</tr>
			<tr>
				<td><a href="http://localhost:8080/CSCI-201-FinalProject-LilRisk/PortfolioPage.jsp" style="text-decoration: none; color: white;">PORTFOLIO 2</a></td>
				<td style="width: 80px"><input type="button" value="2.57%" id="portfolioValue"></td>
			</tr>
			<tr>
				<td><a href="http://localhost:8080/CSCI-201-FinalProject-LilRisk/PortfolioPage.jsp" style="text-decoration: none; color: white;">AGRESSIVE</a></td>
				<td style="width: 80px"><input type="button" value="2.57%" id="portfolioValue"></td>
			</tr>
			<tr>
				<td><a href="http://localhost:8080/CSCI-201-FinalProject-LilRisk/PortfolioPage.jsp" style="text-decoration: none; color: white;">SAFE</a></td>
				<td style="width: 80px"><input type="button" value="2.57%" id="portfolioValue"></td>
			</tr>
			<tr>
				<td><a href="http://localhost:8080/CSCI-201-FinalProject-LilRisk/PortfolioPage.jsp" style="text-decoration: none; color: white;">TECHNOLOGY</a></td>
				<td style="width: 80px"><input type="button" value="2.57%" id="portfolioValue"></td>
			</tr>	
			<tr><td></td></tr>
		</table>		
		
		
		<!-- STOCKS SIDEBAR -->
		<table id= "StockSideBar">
			<tr> 
				<td ><input type= "text" name= "searchBox" id= "SearchBar" placeholder= "Search"></td>
				<td style="width: 80px"></td>
			</tr>
			
			<tr>
				<td>APPL
					<h4 id= "stockFullName"> Apple Inc.</h4>
				</td>
				<td style="width: 80px"><input type="button" value="2.57%" id="portfolioValue"></td>
			</tr>
			<tr>
				<td>GOOG
					<h4 id= "stockFullName"> Alphabet Inc.</h4>
				</td>
				<td style="width: 80px"><input type="button" value="2.57%" id="portfolioValue"></td>
			</tr>
			<tr>
				<td>FB
					<h4 id= "stockFullName"> Facebook Inc.</h4>
				</td>
				<td style="width: 80px"><input type="button" value="2.57%" id="portfolioValue"></td>
			</tr>
			<tr>
				<td>TWTR
					<h4 id= "stockFullName"> Twitter Inc.</h4>
				</td>
				<td style="width: 80px"><input type="button" value="2.57%" id="portfolioValue"></td>
			</tr>
			<tr>
				<td>SNAP
					<h4 id= "stockFullName"> SnapChat Inc.</h4>
				</td>
				<td style="width: 80px"><input type="button" value="2.57%" id="portfolioValue"></td>
			</tr>	
			<tr><td></td></tr>
		</table>		

		<!-- SIDEBAR BUTTONS -->
		<input type="button" id="stocksButton" value="STOCKS" onclick= "loadStocks()">
		<input type="button" id="portfolioButton" value="PORTFOLIOS" onclick= "loadPortfolios()">

		<!-- HISTORY BUTTON -->
		<a href="http://localhost:8080/CSCI-201-FinalProject-LilRisk/HistoryPage.jsp"><input type="button" id="historyButton" value="HISTORY"></a>

		<!-- DONUT CHART -->		
		<div id='donutChart'></div>
		
		<!-- MAIN GRAPH-->		
		<div id='mainGraph'></div>

		<!-- CURRENT STOCKS TABLE -->		
		<table id= "CurrentStocks">
			<tr>
				<th>Symbol</th>
				<th>Last Price</th>
				<th>Today's Gains/Losses</th>
				<th>Current Value</th>
				<th>Quantity</th>
			</tr>
			
			<%int count = 0;%>
			<tr>	
				<td>APPL</td>
				<td>$167.88</td>
				<td style= "color: #2ac940">3.29%</td>
				<td>$1,000</td>
				<td>50</td>
				<%count++;%>
			</tr>
			<tr>	
				<td>GOOG</td>
				<td>$272.14</td>
				<td style= "color: #2ac940">2.12%</td>
				<td>$1,000</td>
				<td>50</td>
				<%count++;%>
			</tr>
			<tr>	
				<td>FB</td>
				<td>$182.82</td>
				<td style= "color: #e10808">9.87%</td>
				<td>$1,000</td>
				<td>50</td>
				<%count++;%>
			</tr>
			<tr>	
				<td>TWTR</td>
				<td>$67.18</td>
				<td style= "color: #2ac940">12.20%</td>
				<td>$1,000</td>
				<td>50</td>
				<%count++;%>
			</tr>
			<tr>	
				<td>SNAP</td>
				<td>$13.29</td>
				<td style= "color: #e10808">21.20%</td>
				<td>$1,000</td>
				<td>50</td>
				<%count++;%>
			</tr>

			<% for (int i = count; i < 5; i++){ %>
				<tr style= "height: 20px">
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<%count++;%>
				</tr>
			<%}%>
		
		</table>

	</body>
</html>