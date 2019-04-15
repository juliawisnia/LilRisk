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

public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("email");
		String password = request.getParameter("pwd");
		String confirmPassword = request.getParameter("cpwd");
		
		if (username == null) response.getWriter().write("Username must not be empty.");
		if (username.equals("no")) response.getWriter().write("Invalid username");
		if (password == null) response.getWriter().write("Password must not be empty.\n");
		if (confirmPassword == null) response.getWriter().write("Confirm Password must not be empty.\n");
		response.setContentType("text/plain");
		HttpSession session = request.getSession();
		session = request.getSession();
		
		Connection conn = null;
		PreparedStatement ps = null;
		PreparedStatement cps = null;
		ResultSet rs = null;
		
		if (password != null && confirmPassword != null && !password.equalsIgnoreCase(confirmPassword)) {
			response.getWriter().write("Passwords must match.");
		}
		else {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/LilRisk?user=root&password=root");
				cps = conn.prepareStatement("SELECT * FROM User WHERE username=?");
				cps.setString(1,  username);
				rs = cps.executeQuery();
				// returned a non-empty result set
				if (rs.next()) {
					response.getWriter().write("Username is already taken.\n");
				} else {
					// we can insert their username now
					ps = conn.prepareStatement("INSERT INTO User VALUES(?,?)");
					ps.setString(1, username); ps.setString(2,  password);
					ps.executeUpdate();
					session.setAttribute("login", username);
					response.getWriter().write("success");
				}
				
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			} catch (ClassNotFoundException cnfe) {
				System.out.println("cnfe: " + cnfe.getMessage());
			} finally {
				try {
					if (rs != null) rs.close();
					if (cps != null) cps.close();
					if (ps != null) ps.close();
					if (conn != null) conn.close();
				} catch (SQLException sqle) {
					System.out.println("sqle closing stuff: " + sqle.getMessage());
				}
			}
		}
		
	}    
}

