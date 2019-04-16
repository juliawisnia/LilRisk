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

@WebServlet("/Portfolio")
public class Portfolio extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String coinSymbol = request.getParameter("symbol");
		String buyPrice = request.getParameter("buyPrice");
		String buyTime = request.getParameter("buyTime");
		String sellPrice = request.getParameter("sellPrice");
		String buyTime = request.getParameter("sellTime");
		String amount = request.getParameter("amount");
		
		if (coinSymbol == null) response.getWriter().write("Coin symbol must not be empty.");
		if (buyPrice == null) response.getWriter().write("Buy price must not be empty.\n");
		if (buyTime == null) response.getWriter().write("Buy time must not be empty.\n");
		if (sellPrice == null) response.getWriter().write("Sell price must not be empty.");
		if (sellTime == null) response.getWriter().write("Sell time must not be empty.\n");
		if (amount == null) response.getWriter().write("Amount must not be empty.\n");
		
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
			conn1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/LilRisk?user=root&password=root");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/LilRisk?user=root&password=root");
			
			ps1 = conn.prepareStatement("SELECT * FROM User WHERE username=?");
			ps1.setString(1,  username);
			rs1 = ps1.executeQuery();
			
			if (!rs1.next()) {
				response.getWriter().write("Username does not exist.");
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
				}
			}
		} catch (SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
				
				if (rs1 != null) {
					rs1.close();
				}
				if (ps1 != null) {
					ps1.close();
				}
				if (conn1 != null) {
					conn1.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle closing stuff: " + sqle.getMessage());
			}
		}
	}


}
