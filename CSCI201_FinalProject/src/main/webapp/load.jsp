<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="coinData.*" %>
<%@ page session="true"%>
<%
	UserClass user = (UserClass)(session.getAttribute("user"));
    String[] dayVals = user.homePageData("day");
    String[] weekVals = user.homePageData("week");
    String[] monthVals = user.homePageData("month");
    String[] sixMonthVals = user.homePageData("month6");
    String[] yearVals = user.homePageData("year");
    
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
    
    session.setAttribute("homeDayVals", dayVals);
	session.setAttribute("homePnDay", pnDay);
	session.setAttribute("homeLenDay", dayVals.length);
	
	session.setAttribute("homeDayData", dayVals[dayVals.length-1]); 
	
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
	    
	    session.setAttribute("homeWeekVals", weekVals);
		session.setAttribute("weekPnDay", pnWeek);
		session.setAttribute("homeLenWeek", weekVals.length);
		
		session.setAttribute("homeWeekData", weekVals[weekVals.length-1]); 
	 
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
    
    session.setAttribute("homeMonthVals", monthVals);
	session.setAttribute("homePnMonth", pnMonth);
	session.setAttribute("homeLenMonth", monthVals.length);
	
	session.setAttribute("homeMonthData", monthVals[monthVals.length-1]);  
    
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
    
    session.setAttribute("homeSixMonthVals", sixMonthVals);
	session.setAttribute("homePnSixMonth", pnSixMonth);
	session.setAttribute("homeLenSixMonth", sixMonthVals.length);
	
	session.setAttribute("homeSixMonthData", sixMonthVals[sixMonthVals.length-1]);  
	
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
    
    session.setAttribute("homeYearVals", yearVals);
	session.setAttribute("homePnYear", pnYear);
	session.setAttribute("homeLenYear", yearVals.length);
	
	session.setAttribute("homeYearData", yearVals[yearVals.length-1]); 
	session.setAttribute("homeTimeFrame", "day");
	
	String redirectURL = "home.jsp";
    response.sendRedirect(redirectURL);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>load</title>
	</head>
	<body>
	
	</body>
</html>