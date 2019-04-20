package Servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

import coinData.UserClass;


@WebServlet("/NewPortfolioServlet")
public class NewPortfolioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session = request.getSession();
		
		UserClass currUser = (UserClass) session.getAttribute("user");
		String port = request.getParameter("portfolio");	
		response.setContentType("text/plain");
		
		currUser.addPortfolio(port);
		response.getWriter().write("success");
	}
	
}

