package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import coinData.UserClass;

/**
 * Servlet implementation class GetPrice
 */
public class GetPrice extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session = request.getSession();
		
		String coin = request.getParameter("coin");
		double q = Double.parseDouble(request.getParameter("q"));
		
		UserClass user = (UserClass) session.getAttribute("user");
		double price = user.getPriceByCoin("coin");
		if (price < 0) {
			response.getWriter().write("no");
		} else {
			double total = q*price;
			response.getWriter().write((int) total);
		}
	}


}
