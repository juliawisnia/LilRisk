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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		if (email == null) {
			request.setAttribute("no-email", "true");
		} if (password == null) {
			request.setAttribute("no-password", "true");
		} if (email == null || password == null) {
			response.getWriter().write("no");
		}
		
		response.setContentType("text/plain");
		HttpSession session = request.getSession();
		session = request.getSession();
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		Connection conn1 = null;
		PreparedStatement ps1 = null;
		ResultSet rs1 = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment3?user=root&password=Secretagent101!");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment3?user=root&password=Secretagent101!");
			
			ps1 = conn.prepareStatement("SELECT * FROM User WHERE username=?");
			ps1.setString(1,  email);
			rs1 = ps1.executeQuery();
			if (!rs1.next()) {
				request.setAttribute("invalid-username", "true");
				response.getWriter().write("no");
			}
			
			else {
				ps = conn.prepareStatement("SELECT * FROM User WHERE username=? AND password=?");
				ps.setString(1, email);
				ps.setString(2, password);
				rs = ps.executeQuery();
				// returned a non-empty result set
				if (rs.next()) {
					response.getWriter().write("success");
				} else {
					request.setAttribute("no-match", "true");
					response.getWriter().write("no");
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
				if (conn1 != null) conn1.close();
				if (rs != null) rs.close();
				if (ps != null) ps.close();
				if (conn != null) conn.close();
			} catch (SQLException sqle) {
				System.out.println("sqle closing stuff: " + sqle.getMessage());
			}
		}
	}
}
