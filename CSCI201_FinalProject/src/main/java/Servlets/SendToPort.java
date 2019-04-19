package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class SendToPort
 */
public class SendToPort extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String port = (String) request.getAttribute("name");
		response.setContentType("text/plain");
		HttpSession session = request.getSession();
		session = request.getSession();
		session.setAttribute("portName", port);
		response.getWriter().write("success");
	}

}
