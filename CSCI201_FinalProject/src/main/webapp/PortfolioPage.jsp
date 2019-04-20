<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="coinData.*" %>
<%@ page session="true"%>

<!DOCTYPE html>
<html>
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
	border-left: 1px solid white;
	padding: 100px 0px;
	position: fixed;
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

ul.PortfolioSideBar input[type=button].none {
	background-color: #313030;
	border-bottom: 1px solid white;
	text-transform: uppercase;
	font-size: 30px;
	color: white;
	font-weight: lighter;
	padding: 12px;
	color: white;
	cursor: pointer;
	text-transform: uppercase;
	font-weight: lighter;
	border: none;
	background-color: rgba(0,0,0,0);
	padding: 0px;
}

ul.StockSideBar {
	width: 100%;
	list-style-type: none;
	padding: 0;
	border-bottom: white;
	overflow-y: scroll;
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
	width: 800px; 
	height: 450px;
	top: 150px;
}

/* DONUT CHART */
#donutChart{
	z-index: 4; 
	position: absolute;
	width: 400px; 
	height: 300px;
	top: 270px; 
	left: 875px;
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
}

ul.buy {
	background-color: rgba(0,0,0,0);
	color: white;
}

ul.buy li {
	background-color: rgba(0,0,0,0);
	font-size: 20px;
	padding-left: 15px;
}

#search {
	position: absolute;
	right: 21px;
	background-color: rgba(0,0,0,0);
	color: white;
	font-size: 15px;
	width: 30%;
	padding-left: 5px;
	line-height: 20px;
	margin-top: 2%;
}
input[type=number]::-webkit-inner-spin-button {
	opacity: 1;
}

.b {
	background-color: rgba(0,0,0,0);
	position: absolute;
	right: 21px;
	color: white;
	width: 30%;
	padding-left: 5px;
}

#purchase {
	position: absolute;
	text-transform: uppercase;
	background-color: rgba(0,0,0,0);
	font-size: 15px;
	color: white;
	border: 1px solid white;
	border-radius: 100px;
	cursor: pointer;
	width: 115px;
	height: 33px;
	left: 28%;
	top: 20%;
}
</style>
	<head>
		<!-- SIDEBAR SCRIPT -->
		<script> 
			function buy(symbol) {
				document.getElementById('search').value = symbol;
			}
			function changeSideBar() {
				if (document.getElementById('PortfolioSideBar').style.display === 'none') {
					document.getElementById('stocksButton').style.backgroundColor = '#313030';
					document.getElementById('portfolioButton').style.backgroundColor = '#7d7d7d';
					document.getElementById('PortfolioSideBar').style.display = 'inline';
					document.getElementById('StockSideBar').style.display = 'none';
					document.getElementById('buy').style.display = 'none';
				}
				else {
					document.getElementById('stocksButton').style.backgroundColor = '#7d7d7d';
					document.getElementById('portfolioButton').style.backgroundColor = '#313030';
					document.getElementById('PortfolioSideBar').style.display = 'none';
					document.getElementById('StockSideBar').style.display = 'inline';
					document.getElementById('buy').style.display = 'inline';
				}
			}

		</script>
		<!-- DONUT CHART SCRIPT -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<script type="text/javascript">
		// Load google charts
		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(drawChart);
		
		// Draw the chart and set the chart values
		function drawChart() {
			<%
				UserClass user = (UserClass)session.getAttribute("user");
				String port = (String)session.getAttribute("portName");
				String timeFrame = (String)(session.getAttribute("timeFrame"));
				String[] syms = null;				
				if (timeFrame.equals("day")) syms = (String[])(session.getAttribute("homeDayVals"));
				else if (timeFrame.equals("week")) syms = (String[])(session.getAttribute("homeWeekVals"));
				else if (timeFrame.equals("month")) syms = (String[])(session.getAttribute("homeMonthVals"));
				else if (timeFrame.equals("sixMonth")) syms = (String[])(session.getAttribute("homeSixMonthVals"));
				else syms = (String[])(session.getAttribute("homeYearVals"));
				
				String pie = user.getPieChart(port);
			%>
			var data = google.visualization.arrayToDataTable(<%=pie%>);
		
		  // Optional; add a title and set the width and height of the chart
		  var options = {
				title:'COINS IN PORTFOLIO',
				legend: {
					position: 'labeled',
					textStyle: {
						color: 'white', 
						fontSize: 16
						},
				},
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
		function purchase() {
			$.ajax({
				url: "PurchaseServlet",
				type: "POST",
				data: {
					coin: document.getElementById('search'),
					quantity: document.getElementById('quantity'),
					portfolio: document.getElementById('curr')
				},
				success: function(result) {
					if (result === "success") {
						location.reload(true);
					} else {
						alert(result);
					}
				}
			})
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
						location.reload(true);
					}
				}
			})
 		}
		</script>
		
		<meta charset="UTF-8">
		<title>Lil Risk</title>
		<link rel="stylesheet" type="text/css" href="PortfolioPage.css" />
	</head>
	<body id="body">
		
	<div id="title"><i><a href="home.jsp">LIL RISK INC.</a></i></div>
	<input type="button" id="stocksButton" value="COINS" onclick= "changeSideBar()">
	<input type="button" id="portfolioButton" value="PORTFOLIOS" onclick= "changeSideBar()">
	<hr style="border: 0.5px solid white;" />
	<body>
		<div class="portfolio-name" id="curr" style="text-transform: uppercase;"><%=(String)session.getAttribute("portName") %></div>
		<div class="form-container">
			<hr style="border: 0.5px solid white; margin-top: 12px;" />
			<ul class="PortfolioSideBar" id="PortfolioSideBar">
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
 				<li><input type="button" class="none" onclick="port(this)" value="<%=syms[i] %>"><div class="per" style="border-color: <%=color%>; color: <%=color%>;"><%=syms[i+1] %></div></li>
 			<%} %>
			</ul>
			<ul class="buy" id="buy" style="display: none;">
				<li style="font-size: 30px;">BUY<input type="text" id="search" value="Search" onfocus="this.value=''"></li>
				<li>SHARES<input type="number" id="quantity" min="1" class="b"></li>
				<li>TOTAL<input type="text" id="total" class="b"></li>
				<li style="padding-bottom: 15px;"><input type="button" onclick="purchase()" id="purchase" value="purchase"></li>
			</ul>
			<ul class="StockSideBar" id="StockSideBar" style="display: none;">
				<%
					String[] coins = (String[])(session.getAttribute("coins"));
					for (int i = 0; i < coins.length; i+=4) {
						String symbol = coins[i]; String name = coins[i+1]; String price = coins[i+2]; double per = Double.parseDouble(coins[i+3]);
						String coinColor = "green";
						if (per < 0) {
							coinColor = "red";
							per = per*(-1);
						}
				%>
				<li class="symbol" style="border-top: 1px solid white;"><input type="button" class="sb" value="<%=symbol %>" onclick="buy(this.value)"><div class="price"><%=price %></div></li>
				<li class="company"><%=name %> <div class="portPer" style="border-color: <%=coinColor%>; color: <%=coinColor%>;"><%=per %></div></li>
				<%} %>
			</ul>
		</div>

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
					<th>Purchase Price</th>
					<th>Last Price</th>
					<th>Gains/losses (%)</th>
					<th>Gains/losses ($)</th>
					<th>Current Value</th>
					<th>Quantity</th>
				</tr>
				<%
					String[] val = user.getPortfolioCoinData(port);
					for (int i = 0; i < val.length; i+=7) {
						String sym = val[i]; String pp = "$" + val[i+1]; String lp = "$" + val[i+2]; double glp = Double.parseDouble(val[i+3]);
						double gld = Double.parseDouble(val[i+4]); String cv = "$" + val[i+5]; String q = val[i+6];
						String gainColor = "green";
						if (glp < 0) {
							gainColor = "red";
							glp = glp*(-1);
							gld = gld*(-1);
						}
						String gp = "$" + Double.toString(gld);
						String gd = Double.toString(glp) + "%";
				%>
				<tr><td><%=sym %></td><td><%=pp %></td><td><%=lp %></td><td style="color: <%=gainColor%>;"><%=gd %></td><td style="color: <%=gainColor%>;"><%=gp %></td><td><%=cv %></td><td><%=q %></td>
				<%} %>
				<tr>
					<th>Total</th>
					<th></th>
					<th></th>
					<th>13.46%</th>
					<th>$5000</th>
					<th></th>
					<th></th>
				</tr>
			</table>
		</div>
	</body>
</html>