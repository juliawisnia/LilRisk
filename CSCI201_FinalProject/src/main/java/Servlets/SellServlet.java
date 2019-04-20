package Servlets;

import java.io.IOException;
import java.time.Instant;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import coinData.UserClass;

public class SellServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session = request.getSession();
		
		String coin = request.getParameter("coin");
		String port = (String)session.getAttribute("portName");
		UserClass user = (UserClass) session.getAttribute("user");
		
		user.sell(port, coin, -1);
		
		response.getWriter().write("success");
	}
}
