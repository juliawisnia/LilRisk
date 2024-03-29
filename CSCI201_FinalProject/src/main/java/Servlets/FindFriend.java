package Servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import coinData.UserClass;

@WebServlet("/FindFriend")
public class FindFriend extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session = request.getSession();
		
		UserClass user = (UserClass)session.getAttribute("user");
		String friend = request.getParameter("friend");
		boolean ok = user.addFriend(friend);
		if (ok) response.getWriter().write("success");
		else response.getWriter().write("The user " + friend + " does not exist.");
	}
}
