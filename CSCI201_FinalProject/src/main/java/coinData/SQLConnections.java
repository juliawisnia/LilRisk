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
			conn = DriverManager.getConnection("jdbc:mysql://50.87.144.88:3306/steelest_LilRisk?useTimezone=true&serverTimezone=PST&user=steelest_liluser&password=lilpassword");
		} catch (ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} catch (SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}
	}
	
	public static void recordTradeInDatabase(Position pos, double avgSellPrice, long sellTime) {
		try {
			PreparedStatement statement = conn.prepareStatement("SELECT * FROM Positions WHERE symbol=?");
			String newTrade = "INSERT INTO Trades(symbol, buyTime, sellTime, buyPrice, sellPrice, amount) VALUES ('" + pos.getName() + "','" + pos.getBuyTime() + "','" + sellTime + "','" + pos.getAvgBuy() + "','" + avgSellPrice + "','" + pos.getAmount() + "')";
			statement.executeUpdate(newTrade);
		} catch (SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}
	}
}
