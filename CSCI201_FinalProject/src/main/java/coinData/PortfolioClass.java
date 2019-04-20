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
import java.util.Vector;

import com.binance.api.client.domain.market.Candlestick;


class timeValue{
	private long time;
	private double value;
	
	public timeValue(long time, double value) {
		this.time = time;
		this.value = value;
	}
	
	public long getTime() {
		return time;
	}
	
	public double getValue() {
		return value;
	}
}

class nameValue{
	private String name;
	private double value;
	
	public nameValue(String name, double value) {
		this.name = name;
		this.value = value;
	}
	
	public String getName() {
		return name;
	}
	
	public double getValue() {
		return value;
	}
	
	public void increaseValue(double value) {
		this.value += value;
	}
}


public class PortfolioClass {
	private String portfolioName;
	private Map<String, Position> coins;
	private List<timeValue> trendInformation;
	private Vector<TradeClass> tradeHistory;
	private double extraMunz;
	private double spentMunz;
	private double balance;
	
	SQLConnections sql = new SQLConnections();

	public PortfolioClass(String portfolioName) {
		this.portfolioName = portfolioName;
		this.coins = Collections.synchronizedMap(new Hashtable<String, Position>());
		this.tradeHistory = new Vector<TradeClass>();
		this.extraMunz = 0;
		this.spentMunz = 0;
		this.balance = 0;
	}
	
	public void addPosition(Position pos) {
		coins.put(pos.getName(), pos);
	}
	
	public void addTrade(TradeClass trade) {
		tradeHistory.add(trade);
	}
	
	/**
	 * 
	 * @param position: coin that you want to
	 */
	public void buy(String coin, double amount, int userID) {
		Connection conn = null;
		PreparedStatement ps = null;
		PreparedStatement getPID = null;
		ResultSet PID = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://50.87.144.88:3306/steelest_LilRisk?useTimezone=true&serverTimezone=PST&user=steelest_liluser&password=lilpassword");
			getPID = conn.prepareStatement("SELECT * FROM Portfolio WHERE userID = ? AND portfolioName = ?");
			getPID.setInt(1, userID);
			getPID.setString(2, this.portfolioName);
			int portfolioID = -1;
			PID = getPID.executeQuery();
			while(PID.next()) {
				portfolioID = PID.getInt("portfolioID");
			}
			double spent;
			if(coins.containsKey(coin)) {
				spent = coins.get(coin).buyMore(amount);
				if(extraMunz-spent < 0) {
					extraMunz = 0;
					spentMunz += spent-extraMunz;
				}
				else {
					extraMunz = extraMunz-spent;
				}
				float curPrice = (float)AllCoins.getCoin(coin).getCurrentPrice();
				ps = conn.prepareStatement("UPDATE Positions SET buyPrice = ?, amount = ? WHERE portfolioID = ? AND symbol = ?");
				ps.setFloat(1, curPrice);
				ps.setFloat(2, (float)amount);
				ps.setInt(3, portfolioID);
				ps.setString(4, coin);
			}
			else {
				Position temp = new Position(coin, amount, System.currentTimeMillis());
				spent = temp.getAvgBuy()*amount;
				ps = conn.prepareStatement("INSERT INTO Positions(portfolioID, symbol, buyTime, buyPrice, amount) VALUE(?,?,?,?,?)");
				ps.setInt(1, portfolioID);
				ps.setString(2, coin);
				ps.setLong(3, temp.getBuyTime());
				ps.setFloat(4, (float)temp.getAvgBuy());
				ps.setFloat(5, (float)amount);
				coins.put(coin, temp);
			}
			spendMunz(spent);
			ps.executeUpdate();
		}
		catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}
		catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		}
		finally{
			try {
				if(PID != null) {
					PID.close();
				}
				if(getPID != null) {
					getPID.close();
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
			
	}
	
	
	public void sell(String coin, double amount, int userID) {
		Connection conn = null;
		PreparedStatement ps = null;
		PreparedStatement ps1 = null;
		PreparedStatement getPID = null;
		ResultSet PID = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://50.87.144.88:3306/steelest_LilRisk?useTimezone=true&serverTimezone=PST&user=steelest_liluser&password=lilpassword");
			getPID = conn.prepareStatement("SELECT * FROM Portfolio WHERE userID = ? and portfolioName = ?");
			getPID.setInt(1, userID);
			getPID.setString(2, this.portfolioName);
			int portfolioID = -1;
			PID = getPID.executeQuery();
			while(PID.next()) {
				portfolioID = PID.getInt("portfolioID");
			}
			Position currentPos = coins.get(coin);
			currentPos.subtractAmount(amount);
			Position tempPos = new Position(coin, currentPos.getAvgBuy(), currentPos.getBuyTime(), amount);
			TradeClass temp = new TradeClass(tempPos, AllCoins.getCoin(coin).getCurrentPrice());
			ps = conn.prepareStatement("INSERT INTO Trades(portfolioID, symbol, buyTime, sellTime, buyPrice, sellPrice, amount) VALUE(?,?,?,?,?,?,?)");
			ps.setInt(1, portfolioID);
			ps.setString(2, coin);
			ps.setLong(3, tempPos.getBuyTime());
			ps.setLong(4, temp.getTime());
			ps.setFloat(5, (float)tempPos.getAvgBuy());
			ps.setFloat(6, (float)temp.getAvgSellPrice());
			ps.setFloat(7, (float)amount);
			tradeHistory.add(temp);
			System.out.println("Current Position Amount: " + currentPos.getAmount());
			if(currentPos.getAmount() <= 0) {
<<<<<<< HEAD
				ps1 = conn.prepareStatement("DELETE FROM Positions WHERE portfolioID = ? AND symbol = ?;");
=======
				ps1 = conn.prepareStatement("DELETE FROM Positions WHERE portfolioID = ? AND symbol = ?");
>>>>>>> 595084f1f8b537b1a7a9d7a4445c54643461c178
				ps1.setInt(1, portfolioID);
				ps1.setString(2, coin);
				ps1.executeUpdate();
				coins.remove(coin);
			}
		}
		catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}
		catch(ClassNotFoundException cnfe){
			System.out.println("cnfe: " + cnfe.getMessage());
		}
		finally {
			try {
				if(ps != null) {
					ps.close();
				}
				if(ps1 != null) {
					ps1.close();
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
	
	public String[] getAllTotals() {
		String[] ret = new String[4];
		double totalValue = 0;
		double totalBuy = 0;
		double totalAmount = 0;
		for (Map.Entry<String,Position> entry : coins.entrySet()) {
			Position temp = entry.getValue();
			totalBuy += temp.getTotalValue();
			totalValue += temp.getAmount()*temp.getCurrentPrice();
			totalAmount += temp.getAmount();
		}
		for (int i = 0; i < tradeHistory.size(); i++) {
			TradeClass temp = tradeHistory.get(i);
			totalBuy += temp.getAvgBuyPrice()*temp.getAmount();
			totalValue += temp.getAmount()*temp.getAvgSellPrice();
		}
		if(totalBuy == 0) {
			ret[0] = "" + 0;
			ret[1] = "" + 0;
			ret[2] = "" + 0;
			ret[3] = "" + 0;
			return ret;
		}
		ret[0] = "" + Math.floor(((totalValue/totalBuy)-1.0) * 100) / 100;
		ret[1] = "" + Math.floor((totalValue-totalBuy) * 100) / 100;
		ret[2] = "" + Math.floor((totalValue) * 100) / 100;
		ret[3] = "" + Math.floor((totalAmount) * 100) / 100;
		return ret;
	}
	
	public String[] getAllHistoryTotals() {
		String[] ret = new String[4];
		double totalValue = 0;
		double totalBuy = 0;
		double totalAmount = 0;
		
		for (int i = 0; i < tradeHistory.size(); i++) {
			TradeClass temp = tradeHistory.get(i);
			totalAmount += temp.getAmount();
			totalBuy += temp.getAvgBuyPrice()*temp.getAmount();
			totalValue += temp.getAmount()*temp.getAvgSellPrice();
		}
		ret[0] = "" + Math.floor((totalValue/totalBuy) * 100) / 100;
		ret[1] = "" + Math.floor((totalValue-totalBuy) * 100) / 100;
		ret[2] = "" + Math.floor((totalAmount) * 100) / 100;
		ret[3] = "" + Math.floor((totalValue) * 100) / 100;
		return ret;
	}
	
	
	
	public double getPercentChange() {
		double totalBuy = 0;
		double totalCurrent = 0;
		for (Map.Entry<String,Position> entry : coins.entrySet()) {
			Position temp = entry.getValue();
			totalBuy += temp.getTotalValue();
			totalCurrent += temp.getAmount()*temp.getCurrentPrice();
		}
		for (int i = 0; i < tradeHistory.size(); i++) {
			TradeClass temp = tradeHistory.get(i);
			totalBuy += temp.getAvgBuyPrice()*temp.getAmount();
			totalCurrent += temp.getAmount()*temp.getAvgSellPrice();
		}
		if(totalBuy != 0) {
			return (totalCurrent/totalBuy)-1.0;
		}
		else {
			return 0;
		}
	}
	
	public void recordTrade(String coin, double avgBuyPrice, double avgSellPrice, double amount, long time) {
		TradeClass executedTrade = new TradeClass(coins.get(coin), avgSellPrice);
		tradeHistory.add(executedTrade);
		double profit = ((avgSellPrice - avgBuyPrice) * amount);
		if (spentMunz <= extraMunz) {
			extraMunz = 0;
			spentMunz += profit;
		}
		else {
			extraMunz += profit;
		}
		SQLConnections.recordTradeInDatabase(coins.get(coin), avgSellPrice, time);
	}
	
	
	/**
	 * 
	 * @return
	 */
	public String getName() {
		return portfolioName;
	}
	
	/**
	 * 
	 * @param munz
	 */
	private void spendMunz(double munz) {
		if(extraMunz-munz < 0) {
			extraMunz = 0;
			spentMunz += munz-extraMunz;
		}
		else {
			extraMunz = extraMunz-munz;
		}
	}
	
	public String[] portfolioCoinData() {
		String data[] = new String[coins.size()*7];
		
		int i = 0;
		for (Map.Entry<String,Position> entry : coins.entrySet()) {
			Position temp = entry.getValue();
			data[i*7] = temp.getName();
			double getAvgBuy = temp.getAvgBuy();
			double curPrice = temp.getCoin().getCurrentPrice();
			double percent = temp.percentDifference();
			double dif = temp.absoluteDifference();
			double value = temp.getCoin().getCurrentPrice()*temp.getAmount();
			data[i*7+1] = "" + Math.floor(getAvgBuy * 100) / 100;
			data[i*7+2] = "" + Math.floor(curPrice * 100) / 100;
			data[i*7+3] = "" + Math.floor((int)(percent * 100)) / 100;
			data[i*7+4] = "" + Math.floor((int)(dif * 100)) / 100;
			data[i*7+5] = "" + Math.floor(value * 100) / 100;
			data[i*7+6] = "" + Math.floor(temp.getAmount()*100)/100;
			i++;
		}
		return data;
	}
	
	public String[] portfolioHistoryData() {
		String data[] = new String[tradeHistory.size()*8];
		for (int i = 0; i < tradeHistory.size(); i++) {
			TradeClass temp = tradeHistory.get(i);
			data[i*8] = temp.getCoin();
			data[i*8+1] = "" + Math.floor(temp.getAvgBuyPrice() * 100) / 100;
			data[i*8+2] = "" + Math.floor(temp.getAvgSellPrice() * 100) / 100;
			data[i*8+3] = "" + Math.floor((temp.getAvgSellPrice()/temp.getAvgBuyPrice()) * 100) / 100;
			data[i*8+4] = "" + Math.floor(((temp.getAvgSellPrice()-temp.getAvgBuyPrice())*temp.getAmount()) * 100) / 100;
			data[i*8+5] = "" + Math.floor(temp.getPosition().getBuyTime() * 100) / 100;
			data[i*8+6] = "" + Math.floor(temp.getTime() * 100) / 100;
			data[i*8+7] = "" + Math.floor(temp.getAmount() * 100) / 100;
		}
		return data;
	}
	
	/**
	 * give the trend of the data for this portfolio on the given time frame
	 * 
	 * @param timeFrame: string of the time frame that you want. Choices: 
	 * min5, halfHour, hours, days
	 * @return a string that can be used in java script on the front end
	 */
	

	public String getPieData() {
		String ret = "";
		for (Map.Entry<String,Position> entry : coins.entrySet()) {
			ret += ",['" + entry.getKey() + "'," + (int)entry.getValue().getTotalValue() + "]";
		}
		return ret;
	}
	
	/**
	 * 
	 * @param timeFrame
	 * @return
	 */
	public String[] portfolioDataWithCoins(String timeFrame) {
		List<timeValue> overAll = this.portfolioTrend(timeFrame);
		List<List<Candlestick>> coinData = Collections.synchronizedList(new ArrayList<List<Candlestick>>());
		String returnString[] = new String[coins.size() +2];
		returnString[0] = portfolioName;
		String ret = "[";
		int k = 1;
		for (Map.Entry<String,Position> entry : coins.entrySet()){
			returnString[k] = entry.getKey();
			coinData.add(entry.getValue().getCoin().getDataList(timeFrame));
			k++;
		}
		if(overAll.size() > 0) {
			ret += "[0," + overAll.get(0).getValue();
			for(int i = 0; i < coinData.size(); i++) {
				ret += "," + coinData.get(i).get(coinData.get(i).size()-(overAll.size())).getOpen();
			}
		}
		for(int j = 0; j < overAll.size(); j++) {
			ret += ",[" + j + "," + overAll.get(j).getValue();
			for(int i = 0; i < coinData.size(); i++) {
				ret += "," + coinData.get(i).get(coinData.get(i).size()-(overAll.size())+j).getOpen();
			}
			ret += "]";
		}
		ret += "]";
		returnString[returnString.length - 1] = ret;
		return returnString;
	}
	
	public Position getPosition(String position) {
		return coins.get(position);
	}
	
	public String[] portfolioDataWithTrades(String timeFrame) {
		List<timeValue> overAll = this.portfolioTrend(timeFrame);
		List<List<timeValue>> coinData = Collections.synchronizedList(new ArrayList<List<timeValue>>());
		String returnString[] = new String[tradeHistory.size() +2];
		returnString[0] = portfolioName;
		String ret = "[";
		int k = 1;
		for (int i = 0; i < tradeHistory.size(); i++){
			returnString[k] = tradeHistory.get(i).getCoin();
			coinData.add(tradeHistory.get(i).timeValueRange(timeFrame));
			k++;
		}
		if(overAll.size() > 0) {
			ret += "[0," + overAll.get(0).getValue();
			for(int i = 0; i < coinData.size(); i++) {
				ret += "," + coinData.get(i).get(coinData.get(i).size()-(overAll.size())).getValue();
			}
		}
		for(int j = 0; j < overAll.size(); j++) {
			ret += ",[" + j + "," + overAll.get(j).getValue();
			for(int i = 0; i < coinData.size(); i++) {
				ret += "," + coinData.get(i).get(coinData.get(i).size()-(overAll.size())+j).getValue();
			}
			ret += "]";
		}
		ret += "]";
		returnString[returnString.length - 1] = ret;
		return returnString;
	}
	
	
	
	/**
	 * 
	 * @param timeFrame
	 * @return
	 */
	public List<timeValue> portfolioTrend(String timeFrame){
		List<timeValue> ret = Collections.synchronizedList(new ArrayList<timeValue>());
		List<List<timeValue>> position = Collections.synchronizedList(new ArrayList<List<timeValue>>());
		for (Map.Entry<String,Position> entry : coins.entrySet()) {
			position.add(entry.getValue().timeValueData(timeFrame));
		}
		for(int i = 0; i < tradeHistory.size(); i++) {
			position.add(tradeHistory.get(i).timeValueRange(timeFrame));
		}
		int longest = 0;
		for(int i = 0; i < position.size(); i++) {
			if(position.get(i).size() > longest) {
				longest = position.get(i).size();
			}
		}
		for(int j = 0; j < longest; j++) {
			double total = 0;
			long time = 0;
			for(int i = 0; i < position.size(); i++) {
				int size = longest - position.get(i).size();
				if(j >= size) {
					time = position.get(i).get(j-size).getTime();
					total += position.get(i).get(j-size).getValue();
				}
			}
			ret.add(new timeValue(time, total));
		}
		return ret;
	}
	
	
	/**
	 * 
	 * @return
	 */
	public double getSpentMunz() {
		return spentMunz;
	}
	
	/**
	 * 
	 * @return
	 */
	public double getExtraMunz() {
		return extraMunz;
	}
	
	public double getBalance() {
		this.balance = calculateBalance();
		return balance;
	}
	
	public double calculateBalance() {
		return (extraMunz - spentMunz);
	}
	
	
	
}
