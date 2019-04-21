package coinData;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.concurrent.locks.Lock;

import com.binance.api.client.BinanceApiClientFactory;
import com.binance.api.client.BinanceApiRestClient;
import com.binance.api.client.domain.market.Candlestick;
import com.binance.api.client.domain.market.CandlestickInterval;

class FriendPortfolioData{
	private String user;
	private String portfolioName;
	private double percentChange;
	private boolean myData;
	
	public FriendPortfolioData(String user, String portfolioName, double percentChange, boolean myData) {
		this.user = user;
		this.portfolioName = portfolioName;
		this.percentChange = percentChange;
		this.myData = myData;
	}
	
	public double getPercentChange() {
		return percentChange;
	}
	
	public String getUser() {
		return user;
	}
	
	public String getPortfolioName() {
		return portfolioName;
	}
	
	public boolean getBool() {
		return myData;
	}
}

class SortFriendPortfolios implements Comparator<FriendPortfolioData>{
	
	public int compare(FriendPortfolioData a, FriendPortfolioData b) {
		if(a.getPercentChange() > b.getPercentChange()) {
			return 1;
		}
		else {
			return -1;
		}
	}
}

public class UserClass {
	private Map<String, PortfolioClass> portfolios = Collections.synchronizedMap(new Hashtable<String, PortfolioClass>());
	private String username;
	private int userID;
	
	public UserClass() {
		UserThread userThread = new UserThread();
		userThread.initialize();
		userThread.start();
		Thread updater = new PriceUpdater();
		updater.start();
		this.username = "";
		this.userID = -1;
	}
	
	public void clearAll() {
		this.username = "";
		this.userID = -1;
		this.portfolios.clear();
	}
	
	public String[] getPortfolioCoinData(String portfolio) {
		return portfolios.get(portfolio).portfolioCoinData();
	}
	
	public String[] getFriendsPortfoliosString() {
		ArrayList<FriendPortfolioData> data = getFriendsPortfolios();
		String ret[] = new String[data.size()*4];
		for(int i = 0; i < data.size(); i+=4) {
			ret[i] = data.get(i).getUser();
			ret[i+1] = data.get(i).getPortfolioName();
			ret[i+2] = "" + data.get(i).getPercentChange();
			ret[i+3] = "" + data.get(i).getBool();
		}
		return ret;
	}
	
	public ArrayList<FriendPortfolioData> getFriendsPortfolios() {
		ArrayList<FriendPortfolioData> ret = new ArrayList<FriendPortfolioData>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		PreparedStatement getUsernames = null;
		ResultSet usernames = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://50.87.144.88:3306/steelest_LilRisk?useTimezone=true&serverTimezone=PST&user=steelest_liluser&password=lilpassword");
			ps = conn.prepareStatement("SELECT * FROM Friends WHERE userID = ?");
			ps.setInt(1,  this.userID);
			rs = ps.executeQuery();
			Set<Integer> userID = new TreeSet<Integer>();
			while(rs.next()) {
				userID.add(rs.getInt("friendID"));
			}
			ArrayList<Integer> userArray = new ArrayList<Integer>();
			ArrayList<String> usernameArray = new ArrayList<String>();
			Iterator<Integer> iter = userID.iterator();
			while(iter.hasNext()) {
				int temp = iter.next();
				getUsernames = conn.prepareStatement("SELECT * FROM User WHERE userID = ?");
				getUsernames.setInt(1, temp);
				usernames = getUsernames.executeQuery();
				if(usernames.next()) {
					usernameArray.add(usernames.getString("username"));
					userArray.add(temp);
				}
				usernames.close();
				getUsernames.close();
			}
			userArray.add(this.userID);
			usernameArray.add(this.username);
			for(int i = 0; i < userArray.size()-1; i++) {
				boolean isThis = (userArray.get(i) == this.userID);
				ArrayList<PortfolioClass> ports = getPortfoliosMultiUser(userArray.get(i));
				for(int j = 0; j < ports.size(); j++)
					ret.add(new FriendPortfolioData(usernameArray.get(i),ports.get(j).getName(), ports.get(j).getPercentChange(), isThis));
			}
		}
		catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}
		catch(ClassNotFoundException cnfe) {
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
				if(usernames != null) {
					usernames.close();
				}
				if(getUsernames != null) {
					getUsernames.close();
				}
				if(conn != null) {
					conn.close();
				}
			}
			catch(SQLException sqle) {
				
			}
		}
		Collections.sort(ret,new SortFriendPortfolios());
		return ret;
	}
	
	private ArrayList<PortfolioClass> getPortfoliosMultiUser(int FID){
		ArrayList<PortfolioClass> ret = new ArrayList<PortfolioClass>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		PreparedStatement ps3 = null;
		ResultSet rs3 = null;
		PreparedStatement ps2 = null;
		ResultSet rs2 = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://50.87.144.88:3306/steelest_LilRisk?useTimezone=true&serverTimezone=PST&user=steelest_liluser&password=lilpassword");
			ps = conn.prepareStatement("SELECT * FROM Portfolio WHERE userID = ?");
			ps.setInt(1, FID);
			rs = ps.executeQuery();
			while(rs.next()) {
				int portfolioID = rs.getInt("portfolioID");
				String portfolioName = rs.getString("portfolioName");
				PortfolioClass temp = new PortfolioClass(portfolioName);
				
				ps2 = conn.prepareStatement("SELECT symbol, buyTime, buyPrice, amount FROM Positions WHERE portfolioID = ?");
				ps2.setInt(1, portfolioID);
				rs2 = ps2.executeQuery();
				while(rs2.next()) {
					temp.addPosition(new Position(rs2.getString("symbol"),rs2.getDouble("buyPrice"), rs2.getLong("buyTime"), rs2.getDouble("amount")));
				}
				
				ps3 = conn.prepareStatement("SELECT symbol, buyTime, sellTime, buyPrice, sellPrice, amount FROM Trades WHERE portfolioID = ?");
				ps3.setInt(1, portfolioID);
				rs3 = ps3.executeQuery();
				while(rs3.next()) {
					temp.addTrade(new TradeClass(new Position(rs3.getString("symbol"),rs3.getDouble("buyPrice"), rs3.getLong("buyTime"), rs3.getDouble("amount")), rs3.getDouble("sellPrice"), rs3.getLong("sellTime")));
				}
				ret.add(temp);
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
		return ret;
	}
	
	public String[] checkFriends() {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		PreparedStatement getUserID = null;
		ResultSet UserID = null;
		PreparedStatement repeatedPS = null;
		ResultSet repeatedResults = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://50.87.144.88:3306/steelest_LilRisk?useTimezone=true&serverTimezone=PST&user=steelest_liluser&password=lilpassword");
			getUserID = conn.prepareStatement("SELECT * FROM Friends WHERE friendID = ?");
			getUserID.setInt(1, this.userID);
			UserID = getUserID.executeQuery();
			Set<Integer> fids = new TreeSet<Integer>();
			if(UserID.next()) {
				fids.add(UserID.getInt("userID"));
			}
			ps = conn.prepareStatement("SELECT * FROM Friends WHERE userID = ?");
			ps.setInt(1, this.userID);
			rs = ps.executeQuery();
			if(rs.next()) {
				fids.remove(rs.getInt("friendID"));
			}
			ArrayList<String> ret = new ArrayList<String>();
			Iterator<Integer> iter = fids.iterator();
			while(iter.hasNext()) {
				int tempUserID = iter.next();
				repeatedPS = conn.prepareStatement("SELECT * FROM User WHERE userID = ?");
				repeatedPS.setInt(1, tempUserID);
				repeatedResults = repeatedPS.executeQuery();
				while(repeatedResults.next()) {
					ret.add(repeatedResults.getString("username"));
					ret.add("" + tempUserID);
				}
				repeatedResults.close();
				repeatedPS.close();
			}
			String returnArray[] = new String[ret.size()];
			for(int i = 0; i < ret.size(); i++) {
				returnArray[i] = ret.get(i);
			}
			for(int i = 0; i< returnArray.length; i++) {
				System.out.println("These are your friend requests: " + returnArray[i]);
			}
			return returnArray;
		}
		catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}
		catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		}
		finally {
			try {
				if(UserID != null) {
					UserID.close();
				}
				if(getUserID != null) {
					getUserID.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
			}
			catch(SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		return null;
	}
	
	public String[] getFriendNames() {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		PreparedStatement getUserID = null;
		ResultSet UserID = null;
		PreparedStatement repeatedPS = null;
		ResultSet repeatedResults = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://50.87.144.88:3306/steelest_LilRisk?useTimezone=true&serverTimezone=PST&user=steelest_liluser&password=lilpassword");
			getUserID = conn.prepareStatement("SELECT * FROM Friends WHERE userID = ?");
			getUserID.setInt(1, this.userID);
			UserID = getUserID.executeQuery();
			Set<Integer> fids = new TreeSet<Integer>();
			if(UserID.next()) {
				fids.add(UserID.getInt("friendID"));
			}
			ArrayList<String> ret = new ArrayList<String>();
			Iterator<Integer> iter = fids.iterator();
			while(iter.hasNext()) {
				int tempUserID = iter.next();
				repeatedPS = conn.prepareStatement("SELECT * FROM User WHERE userID = ?");
				repeatedPS.setInt(1, tempUserID);
				repeatedResults = repeatedPS.executeQuery();
				while(repeatedResults.next()) {
					ret.add(repeatedResults.getString("username"));
					ret.add("" + tempUserID);
				}
				repeatedResults.close();
				repeatedPS.close();
			}
			String returnArray[] = new String[ret.size()];
			for(int i = 0; i < ret.size(); i++) {
				returnArray[i] = ret.get(i);
			}
			return returnArray;
		}
		catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}
		catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		}
		finally {
			try {
				if(UserID != null) {
					UserID.close();
				}
				if(getUserID != null) {
					getUserID.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
			}
			catch(SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		return null;
	}
	
	public boolean addFriend(String username) {
		if(username.equalsIgnoreCase(this.username)) {
			return false;
		}
		Connection conn = null;
		PreparedStatement ps = null;
		PreparedStatement getUserID = null;
		ResultSet UserID = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://50.87.144.88:3306/steelest_LilRisk?useTimezone=true&serverTimezone=PST&user=steelest_liluser&password=lilpassword");
			getUserID = conn.prepareStatement("SELECT * FROM User WHERE username = ?");
			getUserID.setString(1, username);
			UserID = getUserID.executeQuery();
			int uid = 0;
			if(UserID.next()) {
				uid = UserID.getInt("userID");
				ps = conn.prepareStatement("INSERT INTO Friends(userID, friendID) VALUE(?,?);");
				ps.setInt(1, this.userID);
				ps.setInt(2, uid);
				ps.executeUpdate();
				return true;
			}
			else {
				return false;
			}
			
		}
		catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}
		catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		}
		finally {
			try {
				if(UserID != null) {
					UserID.close();
				}
				if(getUserID != null) {
					getUserID.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
			}
			catch(SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		return false;
	}
	
	public void loadUser(int userID, String username) { 
		this.username = username;
		this.userID = userID;
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
			conn = DriverManager.getConnection("jdbc:mysql://50.87.144.88:3306/steelest_LilRisk?useTimezone=true&serverTimezone=PST&user=steelest_liluser&password=lilpassword");
			ps = conn.prepareStatement("SELECT * FROM Portfolio WHERE userID = ?");
			ps.setInt(1, userID);
			rs = ps.executeQuery();
			while(rs.next()) {
				int portfolioID = rs.getInt("portfolioID");
				String portfolioName = rs.getString("portfolioName");
				PortfolioClass temp = new PortfolioClass(portfolioName);
				
				ps2 = conn.prepareStatement("SELECT symbol, buyTime, buyPrice, amount FROM Positions WHERE portfolioID = ?");
				ps2.setInt(1, portfolioID);
				rs2 = ps2.executeQuery();
				while(rs2.next()) {
					temp.addPosition(new Position(rs2.getString("symbol"),rs2.getDouble("buyPrice"), rs2.getLong("buyTime"), rs2.getDouble("amount")));
				}
				
				ps3 = conn.prepareStatement("SELECT symbol, buyTime, sellTime, buyPrice, sellPrice, amount FROM Trades WHERE portfolioID = ?");
				ps3.setInt(1, portfolioID);
				rs3 = ps3.executeQuery();
				while(rs3.next()) {
					temp.addTrade(new TradeClass(new Position(rs3.getString("symbol"),rs3.getDouble("buyPrice"), rs3.getLong("buyTime"), rs3.getDouble("amount")), rs3.getDouble("sellPrice"), rs3.getLong("sellTime")));
				}
				portfolios.put(portfolioName, temp);
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
	
	public void sell(String portfolio, String coin, double amount) {
		if(amount < 0) {
			amount = portfolios.get(portfolio).getPosition(coin).getAmount();
		}
		portfolios.get(portfolio).sell(coin, amount, this.userID);
	}
	
	public double getPriceByCoin(String coin) {
		CoinClass c = AllCoins.getCoin(coin);
		if(c == null) {
			return -1;
		}
		else {
			return c.getCurrentPrice();
		}
	}
	
	public String[] getAllCoins() {
		return AllCoins.allCoinsData();
	}

	public String getPieChart(String portfolio) {
		PortfolioClass target = portfolios.get(portfolio);
		String ret = "[['Coins', 'Value']";
		ret += target.getPieData() + "]";
		return ret;
	}
	
	public double calculateValue(String coin, double amount) {
		return (Math.floor(AllCoins.getCoin(coin).getCurrentPrice()*100*amount)/100);
	}
	
	public String[] portfolioDataWithCoins(String portfolio, String timeFrame) {
		return portfolios.get(portfolio).portfolioDataWithCoins(timeFrame);
	}

	public String[] portfolioDataWithTrades(String portfolio, String timeFrame) {
		return portfolios.get(portfolio).portfolioDataWithTrades(timeFrame);
	}
	
	public String[] portfolioHistoryData(String portfolio) {
		return portfolios.get(portfolio).portfolioHistoryData();
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
	
	public String[] getAllTotals(String portfolio) {
		return portfolios.get(portfolio).getAllTotals();
	}
	
	public String[] getAllHistoryTotals(String portfolio) {
		return portfolios.get(portfolio).getAllHistoryTotals();
	}
	
	private String trend(String coins[], String timeFrame) {
		List<List<Candlestick>> coinValues = Collections.synchronizedList(new ArrayList<List<Candlestick>>());
		int longest = 0;
		int k = 0;
		for(int i = 0; i < coins.length; i++) {
			coinValues.add(AllCoins.getCoin(coins[i]).getDataList(timeFrame));
			if(coinValues.get(i).size() > longest) {
				longest = coinValues.get(i).size();
				k = i;
			}
		}
		if(k != 0) {
			Collections.swap(coinValues, 0, k);
			String temp = coins[0];
			coins[0] = coins[k];
			coins[k] = temp;
		}
		
		String ret = "[";
		if(coinValues.size() != 0) {
			ret += "[0";
			for(int i = 0; i < coinValues.size(); i++) {
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
			ret += ",["+ j;
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
	
	public String[] coinPurchaseData() {
		String data[] = new String[AllCoins.getNumCoins()];
		return null;
	}
	
	public void buyCoin(String portfolio, String coin, double amount) {
		portfolios.get(portfolio).buy(coin, amount, this.userID);
	}
	
	
	public String[] homePageData(String timeFrame) {
		List<List<timeValue>> ports = Collections.synchronizedList(new ArrayList<List<timeValue>>());
		String data[] = new String[portfolios.size()*2+1];
		ArrayList<PortfolioClass> portNames = new ArrayList<PortfolioClass>();
		for (Map.Entry<String,PortfolioClass> entry : portfolios.entrySet()) {
			PortfolioClass tempPort = entry.getValue();
			ports.add(tempPort.portfolioTrend(timeFrame));
			portNames.add(tempPort);
		}
		int longest = 0;
		for(int i = 0; i < ports.size(); i++) {
			if(ports.get(i).size() > longest) {
				longest = ports.get(i).size();
			}
		}
		for(int i = 0; i < portNames.size(); i++) {
			data[i*2] = portNames.get(i).getName();
			double percent = portNames.get(i).getPercentChange();
			percent = Math.floor(percent * 100) / 100;
			data[(i*2)+1] = "" + percent;
		}
		if(ports.size() == 0) {
			data[portfolios.size()*2] = "[]";
			return data;
		}
		String ret = "[";
		if(longest != 0) {
			//String date = (new Date(ports.get(0).get(0).getTime())).toString();
			//date = date.substring(4);
			//date = date.substring(0, 12) + " " + date.substring(20);
			//ret += "["+date + ",0";
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
		for(int j = 1; j < longest; j++) {
			//String date = (new Date(ports.get(0).get(j).getTime())).toString();
			//date = date.substring(4);
			//date = date.substring(0, 12) + " " + date.substring(20);
			//ret += ",["+date + "," + j;
			ret += ",["+ j;
			
			for(int i = 0; i < ports.size(); i++) {
				int size = longest-ports.get(i).size();
				if(j >= size) {
					ret += "," + (int) ports.get(i).get(j-size).getValue();
				}
				else {
					ret += "," + 0;
				}
			}
			ret += "]";
		}
		ret += "]";
		data[portfolios.size()*2] = ret;
		return data;
	}
	
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getUsername() {
		return username;
	}
	
	public void addPortfolio(String portfolioName) {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://50.87.144.88:3306/steelest_LilRisk?useTimezone=true&serverTimezone=PST&user=steelest_liluser&password=lilpassword");
			ps = conn.prepareStatement("INSERT INTO Portfolio(userID, portfolioName) VALUE(?,?);");
			ps.setInt(1, this.userID);
			ps.setString(2, portfolioName);
			ps.executeUpdate();
			portfolios.put(portfolioName, new PortfolioClass(portfolioName));
		}
		catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}
		catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		}
		finally{
			try {
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
			}
			catch(SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
	}
}



