package Servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import coinData.PortfolioClass;
import coinData.Position;
import coinData.TradeClass;

@WebServlet("/Portfolio")
public class Portfolio extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Vector<Position> currentPositions = new Vector<Position>();
	Vector<PortfolioClass> portfolioList = new Vector<PortfolioClass>();
	PortfolioClass currPortfolio;
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String buyButtonDidPressed = request.getParameter("buyButton");
		String sellButtonDidPressed = request.getParameter("sellButton");
		
		String coinSymbol = request.getParameter("symbol");
		String buyPrice = request.getParameter("buyPrice");
		String buyTime = request.getParameter("buyTime");
		String sellPrice = request.getParameter("sellPrice");
		String sellTime = request.getParameter("sellTime");
		String amount = request.getParameter("amount");
		
		String portfolioName = request.getParameter("portfolioName");
		
		if (coinSymbol == null) response.getWriter().write("Coin symbol must not be empty.");
		if (buyPrice == null) response.getWriter().write("Buy price must not be empty.\n");
		if (buyTime == null) response.getWriter().write("Buy time must not be empty.\n");
		if (sellPrice == null) response.getWriter().write("Sell price must not be empty.");
		if (sellTime == null) response.getWriter().write("Sell time must not be empty.\n");
		if (amount == null) response.getWriter().write("Amount must not be empty.\n");
		if (portfolioName == null) response.getWriter().write("Portolio name must not be empty.\n");
		
		currPortfolio = findPortfolio(portfolioName);
		
		
		response.setContentType("text/plain");
		HttpSession session = request.getSession();
		session = request.getSession();
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://50.87.144.88:3306/steelest_LilRisk?useTimezone=true&serverTimezone=PST&user=steelest_liluser&password=lilpassword");
			
			if (buyButtonDidPressed != null && buyButtonDidPressed.length() != 0) {
				Position newPos = new Position(coinSymbol, Double.parseDouble(amount), System.currentTimeMillis());
				currentPositions.add(newPos);
			}
			else if (sellButtonDidPressed != null && sellButtonDidPressed.length() != 0) {
				Position newPos = findPosition(coinSymbol);
				if (newPos != null) {
					TradeClass newTrade = new TradeClass(newPos, Double.parseDouble(sellPrice));
					currPortfolio.recordTrade(newTrade.getCoin(), newTrade.getAvgBuyPrice(), newTrade.getAvgSellPrice(), newTrade.getAmount(), newTrade.getTime());
				}
				else {
					System.out.println("Error: Position for " + coinSymbol + " could not be found.");
				}
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
	
	Position findPosition(String symbol) {
		for (int i = 0; i < currentPositions.size(); i++) {
			if (symbol.equalsIgnoreCase(currentPositions.get(i).getName())) {
				return currentPositions.get(i);
			}
		}
		return null;
	}
	
	PortfolioClass findPortfolio(String pName) {
		for (int i = 0; i < portfolioList.size(); i++) {
			if (pName.equalsIgnoreCase(portfolioList.get(i).getName())) {
				return portfolioList.get(i);
			}
		}
		return null;
	}


}
