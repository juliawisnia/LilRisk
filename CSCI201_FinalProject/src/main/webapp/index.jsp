<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="coinData.*" %>
<%@ page session="true"%>
<%
	UserClass user = new UserClass();
	session.setAttribute("user", user);
	String redirectURL = "UnregisteredHomePage.jsp";
    response.sendRedirect(redirectURL);
    String[] coins = {"ETHUSDT", "BNBUSDT", "LTCUSDT"};
    String[] vals = user.coinTrends(coins);
    session.setAttribute("firstSym", vals[0]);
    session.setAttribute("firstChange", vals[1]);
    session.setAttribute("secondSym", vals[2]);
    session.setAttribute("secondChange", vals[3]);
    session.setAttribute("thirdSym", vals[4]);
    session.setAttribute("thirdChange", vals[5]);
    session.setAttribute("data", vals[6]);
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