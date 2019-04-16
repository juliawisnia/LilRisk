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

import coinData.Position;
import coinData.TradeClass;

@WebServlet("/Portfolio")
public class Portfolio extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String buyButtonDidPressed = request.getParameter("buyButton");
		String sellButtonDidPressed = request.getParameter("sellButton");
		
		String coinSymbol = request.getParameter("symbol");
		String buyPrice = request.getParameter("buyPrice");
		String buyTime = request.getParameter("buyTime");
		String sellPrice = request.getParameter("sellPrice");
		String sellTime = request.getParameter("sellTime");
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
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/LilRisk?user=root&password=root");
			
			if (buyButtonDidPressed != null && buyButtonDidPressed.length() != 0) {
				//IMPLEMENT FOR BUY BUTTON
				Position newPos = new Position(coinSymbol, Double.parseDouble(amount));
			}
			else if (sellButtonDidPressed != null && sellButtonDidPressed.length() != 0) {
				//IMPLEMENT FOR SELL BUTTON
				
				
				Position newPos = null; //PLACEHOLDER/ CHANGE LATER
				
				
				TradeClass newTrade = new TradeClass(newPos, Double.parseDouble(sellPrice));
			}
			
			
			
		} catch (SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} finally {
			try {
				if (rs != null) { rs.close(); }
				if (ps != null) { ps.close(); }
				if (conn != null) { conn.close(); }
			} catch (SQLException sqle) {
				System.out.println("sqle closing stuff: " + sqle.getMessage());
			}
		}
	}


}
