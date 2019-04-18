package Servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.Instant;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import coinData.UserClass;

public class PurchaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String coin = request.getParameter("coin");
		int amount = Integer.parseInt((String)(request.getParameter("quantity")));
		String port = request.getParameter("portfolio");
		long now = Instant.now().toEpochMilli();
		double val = 0;
		
		response.setContentType("text/plain");
		HttpSession session = request.getSession();
		session = request.getSession();
		
		Connection conn = null;
		PreparedStatement ps = null;
		PreparedStatement cps = null;
		PreparedStatement cps1 = null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		
		try {
			int portID = -1;
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/LilRisk?user=root&password=root");
			cps = conn.prepareStatement("SELECT portfolioID FROM Portfolio WHERE portfolioName=?");
			cps.setString(1,  port);
			rs = cps.executeQuery();
			// returned a non-empty result set
			if (rs.next()) {
				portID = rs.getInt("portfolioID");
			} else {
				// we can insert the portfolio now
				ps = conn.prepareStatement("INSERT INTO Positions(portfolioID, symbol, buyTime, buyPrice, amount) VALUES (?,?,?,?,?)");
				ps.setLong(1,  portID); ps.setString(2,  coin); ps.setLong(3, now); ps.setLong(4, x); ps.setLong(5, amount);
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
