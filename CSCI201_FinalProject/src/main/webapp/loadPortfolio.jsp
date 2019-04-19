<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="coinData.*" %>
<%@ page session="true"%>
<%
	UserClass user = (UserClass)(session.getAttribute("user"));
	String[] coins = user.getAllCoins();
	session.setAttribute("coins", coins);
	String redirectURL = "PortfolioPage.jsp";
    response.sendRedirect(redirectURL);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>