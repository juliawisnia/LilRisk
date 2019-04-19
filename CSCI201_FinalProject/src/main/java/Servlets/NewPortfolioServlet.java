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


@WebServlet("/NewPortfolioServlet")
public class NewPortfolioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName = request.getParameter("username");
		String port = request.getParameter("portfolio");
		
		response.setContentType("text/plain");
		
		Connection conn = null;
		PreparedStatement cps = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			int userID = -1;
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://50.87.144.88:3306/steelest_LilRisk?useTimezone=true&serverTimezone=PST&user=steelest_liluser&password=lilpassword");
			
			cps = conn.prepareStatement("SELECT * FROM User WHERE username=?");
			cps.setString(1,  userName);
			rs = cps.executeQuery();
			// returned a non-empty result set
			System.out.println("here1: " + rs);
			System.out.println("uesrname: " + userName);
			System.out.println("port: " + port);
			
			if (rs.next()) {
				userID = rs.getInt("userID");
			} 
			
			// we can insert the portfolio now				
			ps = conn.prepareStatement("INSERT INTO Portfolio(userID, portfolioName) VALUES(?,?)");
			ps.setInt(1, userID);
			ps.setString(2, port);
        	ps.executeUpdate();
			
			response.getWriter().write("success");
        	
		} catch (SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} finally {
			try {
				if (rs != null) rs.close();
				if (ps != null) ps.close();
				if (cps != null) cps.close();
				if (conn != null) conn.close();
			} catch (SQLException sqle) {
				System.out.println("sqle closing stuff: " + sqle.getMessage());
			}
		}
		
	}
	
}

