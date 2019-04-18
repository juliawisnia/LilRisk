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

@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String username = request.getParameter("username");
		String password = request.getParameter("pw");
		String confirmPassword = request.getParameter("cpw");
		
		if (fname == null || fname.equals("First Name") || fname.trim().length() == 0) response.getWriter().write("Must enter a first name.\n");
		if (lname == null || lname.contentEquals("Last Name") || lname.trim().length() == 0) response.getWriter().write("Must enter a last name.\n");
		if (username == null || username.equals("Username") || username.trim().length() == 0) response.getWriter().write("Must enter a username.\n");
		if (password == null || password.equals("Password") || password.length() == 0) response.getWriter().write("Must enter a password.\n");
		if (confirmPassword == null || fname.equals("Confirm Password")  | confirmPassword.length() == 0) response.getWriter().write("Must confirm password.\n");
		
		if (password != null && confirmPassword != null && !password.equals(confirmPassword)) {
			response.getWriter().write("Passwords must match.\n");
		}
		
		response.getWriter().flush();
		
		response.setContentType("text/plain");
		HttpSession session = request.getSession();
		session = request.getSession();
		
		Connection conn = null;
		PreparedStatement ps = null;
		PreparedStatement cps = null;
		ResultSet rs = null;
		
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
				ps = conn.prepareStatement("INSERT INTO User(username, userPassword) VALUES (?,?)");
				ps.setString(1,  username); ps.setString(2,  password);
				ps.executeUpdate();
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

