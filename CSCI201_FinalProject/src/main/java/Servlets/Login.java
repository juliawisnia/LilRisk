package Servlets;

import coinData.UserClass;

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

@WebServlet("/LoginServlet")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("email");
		String password = request.getParameter("pwd");
		
		if (username == null || username.equalsIgnoreCase("Email") || username.equalsIgnoreCase("")) {
			response.getWriter().write("Username must not be empty.");
			response.getWriter().write("failure");
		}
		if (password == null || password.equalsIgnoreCase("Password") || password.equalsIgnoreCase("")) {
			response.getWriter().write("Password must not be empty.");
			response.getWriter().write("failure");
		}
		
		response.setContentType("text/plain");
		HttpSession session = request.getSession();
		session = request.getSession();
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		PreparedStatement ps1 = null;
		ResultSet rs1 = null;
		
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/LilRisk?user=root&password=root");
			
			ps1 = conn.prepareStatement("SELECT * FROM User WHERE username=?");
			ps1.setString(1,  username);
			rs1 = ps1.executeQuery();
			if (!rs1.next()) {
				response.getWriter().write("Username does not exist.");
				response.getWriter().write("failure");
			}
			
			else {
				ps = conn.prepareStatement("SELECT * FROM User WHERE username=? AND userPassword=?");
				ps.setString(1, username);
				ps.setString(2, password);
				rs = ps.executeQuery();
				// returned a non-empty result set
				if (rs.next()) {
					session.setAttribute("login", username);
					response.getWriter().write("success");
				} else {
					response.getWriter().write("Username and password don't match.");
					response.getWriter().write("failure");
				}
			}
		} catch (SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} finally {
			try {
				if (rs1 != null) rs1.close();
				if (ps1 != null) ps1.close();
				if (rs != null) rs.close();
				if (ps != null) ps.close();
				if (conn != null) conn.close();
			} catch (SQLException sqle) {
				System.out.println("sqle closing stuff: " + sqle.getMessage());
			}
		}
	}

}
