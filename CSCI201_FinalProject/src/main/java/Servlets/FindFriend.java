package Servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import coinData.UserClass;

public class FindFriend extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session = request.getSession();
		
		UserClass user = (UserClass)session.getAttribute("user");
		String friend = request.getParameter("friend");
		user.addFriend(friend);

		response.getWriter().write("success");
	}
}
