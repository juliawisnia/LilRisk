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
	private Map<String, PortfolioClass> portfolios = Collections.synchronizedMap(new Hashtable<String, PortfolioClass>());
	private String username;
	
	public UserClass() {
		UserThread userThread = new UserThread();
		userThread.initialize();
		userThread.start();
		Thread updater = new PriceUpdater();
		updater.start();
		this.username = "";
	}
	
	public static void main(String [] args) {
		String coinNames[] = {"BTCUSDT", "ETHUSDT", "BNBUSDT", "NEOUSDT", "LTCUSDT", "QTUMUSDT", "ADAUSDT", "XRPUSDT", "EOSUSDT", "IOTAUSDT", "XLMUSDT", "ONTUSDT", "TRXUSDT", "ETCUSDT", "ICXUSDT", "NULSUSDT", "VETUSDT", "PAXUSDT", "BCHABCUSDT", "BCHSVUSDT", "LINKUSDT", "WAVESUSDT", "BTTUSDT",  "ONGUSDT", "HOTUSDT", "ZILUSDT", "ZRXUSDT", "FETUSDT", "BATUSDT", "XMRUSDT", "ZECUSDT", "IOSTUSDT", "CELRUSDT", "DASHUSDT", "NANOUSDT", "OMGUSDT"};
		UserClass uc = new UserClass();
		String output[] = uc.coinTrends(coinNames, "day");
		for(int i = 0; i < output.length; i++) {
			System.out.println(output[i]);
		}
	}
	
	public void loadUser(int userID, String username) { 
		this.username = username;
		this.portfolios.clear();
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
		String values[] = new String[coins.length*2 + 1];
		for(int i = 0; i < coins.length; i++) {
			values[2*i] = coins[i];
			double percent = AllCoins.getCoin(coins[i]).getDayPercentChange();
			double numPercent = Math.floor(percent * 100) / 100;
			values[2*i + 1] = "" + numPercent;
		}
		values[coins.length*2] = trend(coins, timeFrame);
		return values;
	}
	
	private String trend(String coins[], String timeFrame) {
		List<List<Candlestick>> coinValues = Collections.synchronizedList(new ArrayList<List<Candlestick>>());
		int longest = 0;
		for(int i = 0; i < coins.length; i++) {
			coinValues.add(AllCoins.getCoin(coins[i]).getDataList(timeFrame));
			if(coinValues.get(i).size() > longest) {
				longest = coinValues.get(i).size();
			}
		}
		String ret = "[";
		if(coinValues.size() != 0) {
			ret += "[0";
			for(int i = 0; i < coinValues.size(); i++) {
				System.out.println(i + ":" + coinValues.get(i).size());
				System.out.println("Please print this");
				if(coinValues.get(i).get(0).getOpen().indexOf('.') == -1) {
					ret += "," + coinValues.get(i).get(0).getOpen();
				}
				else {
					ret += "," + coinValues.get(i).get(0).getOpen().substring(0, coinValues.get(i).get(0).getOpen().indexOf('.'));
				}
			}
			ret += "]";
		}
		for(int j = 1; j < longest; j++) {
			ret += ",[" + j;
			for(int i = 0; i < coinValues.size(); i++) {
				if(longest-j <= coinValues.get(i).size()) {
					if(coinValues.get(i).get(j-(longest-coinValues.get(i).size())).getOpen().indexOf('.') == -1) {
						ret += "," + coinValues.get(i).get(j-(longest-coinValues.get(i).size())).getOpen();
					}
					else {
						ret += "," + coinValues.get(i).get(j-(longest-coinValues.get(i).size())).getOpen().substring(0, coinValues.get(i).get(j-(longest-coinValues.get(i).size())).getOpen().indexOf('.'));
					}
					
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
					ret += "," + (int) ports.get(i).get(j+(ports.get(i).size()-longest)).getValue();
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
					time = ports.get(i).get(j-size).getTime();
					total += ports.get(i).get(j-size).getValue();
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



