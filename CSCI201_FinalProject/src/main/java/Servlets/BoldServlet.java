package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class BoldServlet
 */
public class BoldServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String timeframe = request.getParameter("timeframe");
		
		response.setContentType("text/plain");
		HttpSession session = request.getSession();
		session = request.getSession();
		
		if (timeframe.equalsIgnoreCase("1D")) session.setAttribute("timeFrame", "day");
		else if (timeframe.equalsIgnoreCase("1W")) session.setAttribute("timeFrame", "week");
		else if (timeframe.equalsIgnoreCase("1M")) session.setAttribute("timeFrame", "month");
		else if (timeframe.equalsIgnoreCase("6M")) session.setAttribute("timeFrame", "sixMonth");
		else session.setAttribute("timeFrame", "year");
		
		response.getWriter().write("success");	
	}


}
