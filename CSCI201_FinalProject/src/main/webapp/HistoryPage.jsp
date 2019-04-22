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
	margin-top: 32%;
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
input[type=button].lr {
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

#logout {
	position: absolute;
	background-color: #313030;
	border: 1px solid white;
	border-radius: 20px;
	color: white;
 	padding-right: 91px;
	padding-left: 20px; 
	text-align: center;
	font-size: 15px;
	cursor: pointer;
	z-index: 5;
	top: 4%; right: 9.5%;
}

#friends {
	position: absolute;
	background-color: #313030;
	border: 1px solid white;
	color: white;
	border-radius: 60px;
 	padding-right: 80px;
	padding-left: 20px; 
	text-align: center;
	font-size: 15px;
	cursor: pointer;
	z-index: 5;
	top: 4%; right: 2.5%;
}
.time-frames {
	position: absolute;
	top: 63%;
	left: 7%;
	border-collapse: collapse;
	z-index: 5;
}
input[type=button].time {
	cursor: pointer;
	border: none;
	background-color: rgba(0,0,0,0);
	font-size: 20px;
	color: white;
}
</style>
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
 		function logout() {
 			window.location.href = "UnregisteredHomePage.jsp";
 		}
 		function friends() {
 			window.location.href = "FriendsPage.jsp";
 		}
		</script>
		
		
		<script type="text/javascript">
		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(drawChart);
		
	 	function drawChart() {
	 		var data = new google.visualization.DataTable();
			data.addColumn('number', 'X');
			<%
				String symss[] = null;
				if (timeFrame.equals("day")) {
					symss = user.portfolioDataWithTrades(port,"day");
				}
				else if (timeFrame.equals("week")) {
					symss = user.portfolioDataWithTrades(port,"week");
				}
				else if (timeFrame.equals("month")) {
					symss = user.portfolioDataWithTrades(port,"month");
				}
				else if (timeFrame.equals("sixMonth")) {
					symss = user.portfolioDataWithTrades(port,"month6");
				}
				else {
					symss = user.portfolioDataWithTrades(port,"year");
				}
				session.setAttribute("portfolioGraphData", symss[symss.length-1]);
				String sym = "";
				for (int i = 0; i < symss.length - 1; i++) {
					sym = symss[i];
			%>
				data.addColumn('number', "<%=sym %>");
			<%}%>
			
			var vals = <%=session.getAttribute("portfolioGraphData")%>;
			var timeFrame = "<%= session.getAttribute("timeFrame")%>";
			if (timeFrame === "day") {
				document.getElementById('day').style.fontWeight = 'bold';
				document.getElementById('week').style.fontWeight = 'normal';
				document.getElementById('month').style.fontWeight = 'normal';
				document.getElementById('sixMonth').style.fontWeight = 'normal';
				document.getElementById('year').style.fontWeight = 'normal';
			}
			else if (timeFrame === "week") {
				document.getElementById('day').style.fontWeight = 'normal';
				document.getElementById('week').style.fontWeight = 'bold';
				document.getElementById('month').style.fontWeight = 'normal';
				document.getElementById('sixMonth').style.fontWeight = 'normal';
				document.getElementById('year').style.fontWeight = 'normal';
			}
			else if (timeFrame === "month") {
				document.getElementById('day').style.fontWeight = 'normal';
				document.getElementById('week').style.fontWeight = 'normal';
				document.getElementById('month').style.fontWeight = 'bold';
				document.getElementById('sixMonth').style.fontWeight = 'normal';
				document.getElementById('year').style.fontWeight = 'normal';
			}
			else if (timeFrame === "sixMonth") {
				document.getElementById('day').style.fontWeight = 'normal';
				document.getElementById('week').style.fontWeight = 'normal';
				document.getElementById('month').style.fontWeight = 'normal';
				document.getElementById('sixMonth').style.fontWeight = 'bold';
				document.getElementById('year').style.fontWeight = 'normal';
			}
			else {
				document.getElementById('day').style.fontWeight = 'normal';
				document.getElementById('week').style.fontWeight = 'normal';
				document.getElementById('month').style.fontWeight = 'normal';
				document.getElementById('sixMonth').style.fontWeight = 'normal';
				document.getElementById('year').style.fontWeight = 'bold';
			}
			
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
						italic: false 
					},
					baselineColor: 'white',
					title: 'PORTFOLIO VALUE',
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
			
			var chart = new google.visualization.LineChart(document.getElementById('mainGraph'));
			
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
 		function changeTime(element) {
			$.ajax({
				url: "BoldServlet",
				type: "POST",
				data: {
					timeframe: element.value
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
		<input class="lr" type="button" id="logout" value="SIGN OUT" onclick="logout()">
		<input class="lr" type="button" id="friends" value="FRIENDS" onclick="friends()">
		
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
				else {
					tempPer = Double.parseDouble(totals[0]);
					tempDoll = Double.parseDouble(totals[1]);
					gainColor = "green";
				}
				String perChange = tempPer + "%";
				String dollChange = "$" + tempDoll;
				
				String quanTotal = 	totals[2];
				
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
			<table class="time-frames">
			<tr>
				<th><input type="button" id="day" class="time" onclick="changeTime(this)" value="1D"></th>
				<th><input type="button" id="week" class="time" onclick="changeTime(this)" value="1W"></th>
				<th><input type="button" id="month" class="time" onclick="changeTime(this)" value="1M"></th>
				<th><input type="button" id="sixMonth" class="time" onclick="changeTime(this)" value="6M"></th>
				<th><input type="button" id="year" class="time" onclick="changeTime(this)" value="1Y"></th>
			</tr>
		</table>
		</div>
	</body>
</html>