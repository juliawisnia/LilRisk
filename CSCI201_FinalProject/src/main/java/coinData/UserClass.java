package coinData;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.locks.Lock;

import com.binance.api.client.BinanceApiClientFactory;
import com.binance.api.client.BinanceApiRestClient;
import com.binance.api.client.domain.market.Candlestick;
import com.binance.api.client.domain.market.CandlestickInterval;

public class UserClass {
	private static Map<String, PortfolioClass> portfolios = Collections.synchronizedMap(new Hashtable<String, PortfolioClass>());
	private String username;
	
	public UserClass() {
		UserThread userThread = new UserThread();
		userThread.initialize();
		userThread.start();
		Thread updater = new PriceUpdater();
		updater.start();
		this.username = "";
	}
	
	public void loadUser(int userID) { 
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		PreparedStatement ps3 = null;
		ResultSet rs3 = null;
		PreparedStatement ps2 = null;
		ResultSet rs2 = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/LilRisk?user=root&password=root");
			ps = conn.prepareStatement("SELECT * FROM Portfolio WHERE userID = ?");
			ps.setInt(1, userID);
			rs = ps.executeQuery();
			while(rs.next()) {
				int portfolioID = rs.getInt("portfolioID");
				String portfolioName = rs.getString("portfolioName");
				PortfolioClass temp = new PortfolioClass(portfolioName);
				
				ps2 = conn.prepareStatement("SELECT symbol, buyTime, buyPrice, amount FROM Positions p WHERE portfolioID = ?");
				ps2.setInt(1, portfolioID);
				rs2 = ps2.executeQuery();
				while(rs2.next()) {
					temp.addPosition(new Position(rs2.getString("symbol"),rs2.getDouble("buyPrice"), rs2.getDate("buyTime").getTime(), rs2.getDouble("amount")));
				}
				
				ps3 = conn.prepareStatement("SELECT symbol, buyTime, sellTime, buyPrice, sellPrice, amount FROM Positions p WHERE portfolioID = ?");
				ps3.setInt(1, portfolioID);
				rs3 = ps3.executeQuery();
				while(rs3.next()) {
					temp.addTrade(new TradeClass(new Position(rs3.getString("symbol"),rs3.getDouble("buyPrice"), rs3.getDate("buyTime").getTime(), rs3.getDouble("amount")), rs3.getDouble("avgSell"), rs3.getDate("sellTime").getTime()));
				}
			}
			
		}
		catch (SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}
		catch (ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		}
		finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(rs2 != null) {
					rs2.close();
				}
				if(ps2 != null) {
					ps2.close();
				}
				if(rs3 != null) {
					rs3.close();
				}
				if(ps3 != null) {
					ps3.close();
				}
				if(conn != null) {
					conn.close();
				}
			}
			catch(SQLException sqle) {
				System.out.println("sqle closing stuff: " + sqle.getMessage());
			}
		}
	}

	public String[] coinTrends(String coins[], String timeFrame) {
		String key = "CFQvKQ9Xuf7L6mf8i7qqCoDmrK9C6XzGibUWXvTB4nagC3OblBlMTj49BNHV3qjN";
		String secret = "PTJVaWQd9DCW2ysn7ATdLf1T9F8eheEe29mEVfIx9BML92N1dC95nk7jfn8tFplM";
		BinanceApiClientFactory factory = BinanceApiClientFactory.newInstance(key, secret);
		BinanceApiRestClient client = factory.newRestClient();
		
		String values[] = new String[coins.length*2 + 1];
		for(int i = 0; i < coins.length; i++) {
			values[2*i] = coins[i];
			String percent = client.get24HrPriceStatistics(coins[i]).getPriceChangePercent();
			double numPercent = Math.floor(Double.parseDouble(percent) * 100) / 100;
			values[2*i + 1] = "" + numPercent;
		}
		values[coins.length*2] = trend(coins, timeFrame);
		return values;
	}
	
	private String trend(String coins[], String timeFrame) {
		String key = "CFQvKQ9Xuf7L6mf8i7qqCoDmrK9C6XzGibUWXvTB4nagC3OblBlMTj49BNHV3qjN";
		String secret = "PTJVaWQd9DCW2ysn7ATdLf1T9F8eheEe29mEVfIx9BML92N1dC95nk7jfn8tFplM";
		BinanceApiClientFactory factory = BinanceApiClientFactory.newInstance(key, secret);
		BinanceApiRestClient client = factory.newRestClient();
		
		List<List<Candlestick>> coinValues = Collections.synchronizedList(new ArrayList<List<Candlestick>>());
		CandlestickInterval ci = null;
		long dayTime = 24*60*60*1000;
		if(timeFrame.equalsIgnoreCase("day")) {
			ci = CandlestickInterval.THREE_MINUTES;
		}
		else if(timeFrame.equalsIgnoreCase("week")) {
			ci = CandlestickInterval.THREE_MINUTES;
			dayTime = 24*60*60*1000*7;
		}
		else if(timeFrame.equalsIgnoreCase("month")) {
			ci = CandlestickInterval.THREE_MINUTES;
			dayTime = 24*60*60*1000*30;
		}
		else if(timeFrame.equalsIgnoreCase("month6")) {
			ci = CandlestickInterval.THREE_MINUTES;
			dayTime = 24*60*60*1000*30*6;
		}
		else if(timeFrame.equalsIgnoreCase("year")) {
			ci = CandlestickInterval.THREE_MINUTES;
			dayTime = 24*60*60*1000*365;
		}
		for(int i = 0; i < coins.length; i++) {
			coinValues.add(client.getCandlestickBars(coins[i], ci, 500, System.currentTimeMillis()-dayTime, System.currentTimeMillis()));
		}
		String ret = "[";
		if(coins.length != 0) {
			ret += "[0";
			for(int i = 0; i < coinValues.size(); i++) {
				ret += "," + coinValues.get(i).get(0).getOpen().substring(0, coinValues.get(i).get(0).getOpen().indexOf('.'));
			}
			ret += "]";
		}
		for(int j = 1; j < coinValues.get(0).size(); j++) {
			ret += ",[" + j;
			for(int i = 0; i < coinValues.size(); i++) {
				if(i < coinValues.get(i).size()) {
					ret += "," + coinValues.get(i).get(j).getOpen().substring(0, coinValues.get(i).get(j).getOpen().indexOf('.'));
				}
				else {
					ret += "," + 0;
				}
			}
			ret += "]";
		}
			
		ret += "]";
		return ret;
	}
	
	public String trends(String timeFrame) {
		String ret = "[";
		List<List<timeValue>> ports = Collections.synchronizedList(new ArrayList<List<timeValue>>());
		Set<String> keys = portfolios.keySet();
		Iterator<String> iter = keys.iterator();
		while(iter != null) {
			ports.add(portfolios.get(iter.next()).portfolioTrend(timeFrame));
		}
		int longest = 0;
		for(int i = 0; i < ports.size(); i++) {
			if(ports.get(i).size() > longest) {
				longest = ports.get(i).size();
			}
		}
		if(ports.get(0).size() != 0) {
			ret += "[0";
			for(int i = 0; i < ports.size(); i++) {
				if(ports.get(i).size()-longest == 0) {
					ret += "," + (int) ports.get(i).get(0).getValue();
				}
				else {
					ret += "," + 0;
				}
				
			}
			ret += "]";
		}
		for(int j = 1; j < ports.get(0).size(); j++) {
			ret += ",[" + j;
			for(int i = 0; i < ports.size(); i++) {
				if(ports.get(i).size()-longest > 0) {
					ret += "," + (int) ports.get(i).get(j).getValue();
				}
				else {
					ret += "," + 0;
				}
				
			}
			ret += "]";
		}
		ret += "]";
		return ret;
	}
	
	public List<timeValue> getPorfolioTrends(String timeFrame) {
		List<timeValue> ret = Collections.synchronizedList(new ArrayList<timeValue>());
		List<List<timeValue>> ports = Collections.synchronizedList(new ArrayList<List<timeValue>>());
		Set<String> keys = portfolios.keySet();
		Iterator<String> iter = keys.iterator();
		while(iter != null) {
			ports.add(portfolios.get(iter.next()).portfolioTrend(timeFrame));
			
		}
		int longest = 0;
		for(int i = 0; i < ports.size(); i++) {
			if(ports.get(i).size() > longest) {
				longest = ports.get(i).size();
			}
		}
		for(int i = 0; i < ports.size(); i++) {
			for(int j = 0; j < longest; i++) {
				double total = 0;
				long time = 0;
				int size = longest - ports.get(i).size();
				if(j >= size) {
					time = ports.get(i).get(j).getTime();
					total += ports.get(i).get(j).getValue();
				}
				ret.add(new timeValue(time, total));
			}
				
		}
		return ret;
	}
	
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getUsername() {
		return username;
	}
}



