package coinData;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SQLConnections {
	static Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public static void connectToDatabase() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/LilRisk?user=root&password=root");
		} catch (ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} catch (SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}
	}
	
	public static void recordTradeInDatabase(Position pos, double avgSellPrice, long sellTime) {
		try {
			PreparedStatement statement = conn.prepareStatement("SELECT * FROM Positions WHERE symbol=?");
			String newUser = "INSERT INTO User(symbol, buyTime, sellTime, buyPrice, sellPrice, amount) VALUES ('" + pos.getName() + "','" + pos.getBuyTime() + "','" + sellTime + "','" + pos.getAvgBuy() + "','" + avgSellPrice + "','" + pos.getAmount() + "')";
			statement.executeUpdate(newUser);
		} catch (SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}
	}
}
