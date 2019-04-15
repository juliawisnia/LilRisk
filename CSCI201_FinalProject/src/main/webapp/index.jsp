<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="coinData.*" %>
<%@ page session="true"%>
<%
	UserClass user = new UserClass();
	session.setAttribute("user", user);
	String redirectURL = "UnregisteredHomePage.jsp";
    response.sendRedirect(redirectURL);
    String[] coins = {"BTCUSDT", "ETHUSDT", "BNBUSDT", "NEOUSDT", "LTCUSDT", "QTUMUSDT", "ADAUSDT", "XRPUSDT", "EOSUSDT", "IOTAUSDT", "XLMUSDT", "ONTUSDT", "TRXUSDT", "ETCUSDT", "ICXUSDT"};
    String[] dayVals = user.coinTrends(coins, "DAY");
    String[] weekVals = user.coinTrends(coins, "WEEK");
    String[] monthVals = user.coinTrends(coins, "MONTH");
    String[] sixMonthVals = user.coinTrends(coins, "MONTH6");
    String[] yearVals = user.coinTrends(coins, "YEAR");
    
    String[] pnDay = new String[1000];
    String[] pnWeek = new String[1000];
    String[] pnMonth = new String[1000];
    String[] pnSixMonth = new String[1000];
    String[] pnYear = new String[1000]; 
    
    /* DAY */
    
    int cnt = 0;
    for (int i = 1; i < dayVals.length - 1; i+=2) {
    	String c = "";
    	String se = Integer.toString(i);
    	if (dayVals[i].charAt(0) == '-') {
    		pnDay[cnt] = "n";
    		for (int j = 1; j < dayVals[i].length(); j++) {
    			c += dayVals[i].charAt(j);
    		}
    		c += '%';
    	}
    	else {
    		pnDay[cnt] = "p";
    		c = dayVals[i] + '%';
    	}
    	dayVals[i] = c;
    	cnt++;
    }   	
    
    session.setAttribute("dayVals", dayVals);
	session.setAttribute("pnDay", pnDay);
	session.setAttribute("lenDay", dayVals.length);
	
	session.setAttribute("dayData", dayVals[dayVals.length-1]); 
	
	/* WEEK */
	
 	cnt = 0;
	    for (int i = 1; i < weekVals.length - 1; i+=2) {
	    	String c = "";
	    	String se = Integer.toString(i);
	    	if (weekVals[i].charAt(0) == '-') {
	    		pnWeek[cnt] = "n";
	    		for (int j = 1; j < weekVals[i].length(); j++) {
	    			c += weekVals[i].charAt(j);
	    		}
	    		c += '%';
	    	}
	    	else {
	    		pnWeek[cnt] = "p";
	    		c = weekVals[i] + '%';
	    	}
	    	weekVals[i] = c;
	    	cnt++;
	    }
	    
	    session.setAttribute("weekVals", weekVals);
		session.setAttribute("pnWeek", pnWeek);
		session.setAttribute("lenWeek", weekVals.length);
		
		session.setAttribute("weekData", weekVals[weekVals.length-1]); 
	 
		/* MONTH */	
		
     cnt = 0;
    for (int i = 1; i < monthVals.length - 1; i+=2) {
    	String c = "";
    	String se = Integer.toString(i);
    	if (monthVals[i].charAt(0) == '-') {
    		pnMonth[cnt] = "n";
    		for (int j = 1; j < monthVals[i].length(); j++) {
    			c += monthVals[i].charAt(j);
    		}
    		c += '%';
    	}
    	else {
    		pnMonth[cnt] = "p";
    		c = monthVals[i] + '%';
    	}
    	monthVals[i] = c;
    	cnt++;
    }
    
    session.setAttribute("monthVals", monthVals);
	session.setAttribute("pnMonth", pnMonth);
	session.setAttribute("lenMonth", monthVals.length);
	
	session.setAttribute("monthData", monthVals[monthVals.length-1]);  
    
	/* SIX MONTHS */
 	
    cnt = 0;
    for (int i = 1; i < sixMonthVals.length - 1; i+=2) {
    	String c = "";
    	String se = Integer.toString(i);
    	if (sixMonthVals[i].charAt(0) == '-') {
    		pnSixMonth[cnt] = "n";
    		for (int j = 1; j < sixMonthVals[i].length(); j++) {
    			c += sixMonthVals[i].charAt(j);
    		}
    		c += '%';
    	}
    	else {
    		pnSixMonth[cnt] = "p";
    		c = sixMonthVals[i] + '%';
    	}
    	sixMonthVals[i] = c;
    	cnt++;
    }
    
    session.setAttribute("sixMonthVals", sixMonthVals);
	session.setAttribute("pnSixMonth", pnSixMonth);
	session.setAttribute("lenSixMonth", sixMonthVals.length);
	
	session.setAttribute("sixMonthData", sixMonthVals[sixMonthVals.length-1]);  
	
	/* YEAR */
	
    cnt = 0;
    for (int i = 1; i < yearVals.length - 1; i+=2) {
    	String c = "";
    	String se = Integer.toString(i);
    	if (yearVals[i].charAt(0) == '-') {
    		pnYear[cnt] = "n";
    		for (int j = 1; j < yearVals[i].length(); j++) {
    			c += yearVals[i].charAt(j);
    		}
    		c += '%';
    	}
    	else {
    		pnYear[cnt] = "p";
    		c = yearVals[i] + '%';
    	}
    	yearVals[i] = c;
    	cnt++;
    }
    
    session.setAttribute("yearVals", yearVals);
	session.setAttribute("pnYear", pnYear);
	session.setAttribute("lenYear", yearVals.length);
	
	session.setAttribute("yearData", yearVals[yearVals.length-1]); 
	session.setAttribute("timeFrame", "day");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>index</title>
	</head>
	<body>
	
	</body>
</html>