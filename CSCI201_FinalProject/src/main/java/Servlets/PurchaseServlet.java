package Servlets;

import java.io.IOException;
import java.time.Instant;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import coinData.UserClass;

public class PurchaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session = request.getSession();
		
		String coin = request.getParameter("coin");
		int amount = Integer.parseInt((String)(request.getParameter("quantity")));
		String port = (String) session.getAttribute("portName");
		UserClass currUser = (UserClass) session.getAttribute("user");
		
		currUser.buyCoin(port, coin, amount);
		
		response.getWriter().write("success");
	}
}
