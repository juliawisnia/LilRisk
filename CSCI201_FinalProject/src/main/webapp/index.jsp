<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="coinData.*" %>
<%@ page session="true"%>
<%
	UserClass user = new UserClass();
	session.setAttribute("user", user);
	String redirectURL = "UnregisteredHomePage.jsp";
    response.sendRedirect(redirectURL);
    String[] coins = {"BTCUSDT", "ETHUSDT", "BNBUSDT", "BCCUSDT", "NEOUSDT", "LTCUSDT", "QTUMUSDT", "ADAUSDT", "XRPUSDT", "EOSUSDT", "TUSDUSDT", "IOTAUSDT", "XLMUSDT", "ONTUSDT", "TRXUSDT", "ETCUSDT", "ICXUSDT", "VENUSDT", "NULSUSDT", "VETUSDT", "PAXUSDT", "BCHABCUSDT", "BCHSVUSDT", "USDCUSDT", "LINKUSDT", "WAVESUSDT", "BTTUSDT", "USDSUSDT", "ONGUSDT", "HOTUSDT", "ZILUSDT", "ZRXUSDT", "FETUSDT", "BATUSDT", "XMRUSDT", "ZECUSDT", "IOSTUSDT", "CELRUSDT", "DASHUSDT", "NANOUSDT", "OMGUSDT"};
    String[] vals = user.coinTrends(coins);
    
    String[] pn = new String[1000];
    int cnt = 0;
    for (int i = 1; i < vals.length - 1; i+=2) {
    	String c = "";
    	String se = Integer.toString(i);
    	if (vals[i].charAt(0) == '-') {
    		pn[cnt] = "n";
    		for (int j = 1; j < vals[i].length(); j++) {
    			c += vals[i].charAt(j);
    		}
    		c += '%';
    	}
    	else {
    		pn[cnt] = "p";
    		c = vals[i] + '%';
    	}
    	vals[i] = c;
    	cnt++;
    }
    
	session.setAttribute("vals", vals);
	session.setAttribute("pn", pn);
	session.setAttribute("len", vals.length);
	
	session.setAttribute("data", vals[vals.length-1]);
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