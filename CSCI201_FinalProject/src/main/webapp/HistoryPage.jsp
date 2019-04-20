<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="coinData.*" %>
<%@ page session="true"%>

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
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<!-- MAIN GRAPH -->
		<script type="text/javascript">
		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(drawChart);
		
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
		%>
		
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
		function hist(element) {
			$.ajax({				
				url: "HistServlet",
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
	</head>
	<body id="body">
		
	<div id="title"><i><a href="home.jsp">LIL RISK INC.</a></i></div>
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
 				<li><input type="button" class="none" onclick="hist(this)" value="<%=syms[i] %>"><div class="per" style="border-color: <%=color%>; color: <%=color%>;"><%=syms[i+1] %></div></li>
 			<%} %>
			</ul>
		</div>		
		<!-- MAIN GRAPH-->		
		<div id="mainGraph" style="position: fixed; z-index: 1;"></div>
		
		<div class="stocks-container">
			<table class="stocks">
				<tr>
					<th>Symbol</th>
					<th>Purchase Price</th>
					<th>Sell Price</th>
					<th>Gains/losses (%)</th>
					<th>Gains/losses ($)</th>
					<th>Time Purchased</th>
					<th>Time Sold</th>
					<th>Quantity</th>
					<th>Current Value</th>
				</tr>
				<%
					String[] val = user.portfolioHistoryData(port);
					for (int i = 0; i < val.length; i+=8) {
						String symbol = val[i]; 
						String buyPrice = "$" + val[i+1]; 
						String sellPrice = "$" + val[i+2]; 
						double percentChange = Double.parseDouble(val[i+3]); 
						double dollarChange = Double.parseDouble(val[i+4]); 
						String timeBought = val[i+5]; 
						String timeSold = val[i+6]; 
						String quantity = val[i+7]; 
						String gainColor = "green";
						if (percentChange < 0 || dollarChange < 0) {
							gainColor = "red";
							percentChange = Math.abs(percentChange);
							dollarChange = Math.abs(dollarChange);
						}
						String gd = "$" + Double.toString(dollarChange);
						String gp = Double.toString(percentChange) + "%";
				%>
				<tr><td><%=symbol %></td><td><%=buyPrice %></td><td><%=sellPrice %></td><td style="color: <%=gainColor%>;"><%=gp %></td><td style="color: <%=gainColor%>;"><%=gd %></td><td><%=timeBought %></td><td><%=timeSold %></td><td><%=quantity %></td><td></td>
				<%} %> 
				<tr>
					<th>Total</th>
					<th></th>
					<th></th>
				<%

				String[] totals = user.getAllHistoryTotals(port);
				String gainColor = "green";
				double tempPer = 0;
				double tempDoll = 0;
				
				if (Double.parseDouble(totals[0]) < 0) {
					tempPer = Double.parseDouble(totals[0]) * (-1);
					tempDoll = Double.parseDouble(totals[1]) * (-1);
					gainColor = "red";
				}
				String perChange = tempPer + "%";
				String dollChange = "$" + tempDoll;
				
				String quanTotal = 	totals[3];
				
				String  totPort= "$" + totals[3];

				%>
				<th style="color: <%=gainColor%>"><%= perChange %></th>
				<th style="color: <%=gainColor%>"><%= dollChange %></th>
				<th></th>
				<th></th>
				<th style="color: white"><%= quanTotal %></th>
				<th style="color: white"><%= totPort %></th>
				</tr>
			</table>
		</div>
	</body>
</html>