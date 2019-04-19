package coinData;

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
	public void buy(String coin, double amount) {
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
		}
		else {
			Position temp = new Position(coin, amount, System.currentTimeMillis());
			coins.put(coin, temp);
			spent = temp.getAvgBuy();
			
		}
		spendMunz(spent);
	}
	
	
	public void sell(String pos, double avgSellPrice, double amount) {
		//recordTrade(pos.getName(), pos.getAvgBuy(), avgSellPrice, pos.getAmount(), System.currentTimeMillis());
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
			data[i*7+1] = "" + temp.getAvgBuy();
			data[i*7+2] = "" + temp.getCoin().getCurrentPrice();
			data[i*7+3] = "" + temp.percentDifference();
			data[i*7+4] = "" + temp.absoluteDifference();
			data[i*7+5] = "" + temp.getCoin().getCurrentPrice();
			data[i*7+6] = "" + temp.getAmount();
		}
		return data;
	}
	
	public String[] portfolioHistoryData() {
		String data[] = new String[tradeHistory.size()*8];
		for (int i = 0; i < tradeHistory.size(); i++) {
			TradeClass temp = tradeHistory.get(i);
			data[i*8] = temp.getCoin();
			data[i*8+1] = "" + temp.getAvgBuyPrice();
			data[i*8+2] = "" + temp.getAvgSellPrice();
			data[i*8+3] = "" + (temp.getAvgSellPrice()/temp.getAvgBuyPrice());
			data[i*8+4] = "" + ((temp.getAvgSellPrice()-temp.getAvgBuyPrice())*temp.getAmount());
			data[i*8+5] = "" + temp.getPosition().getBuyTime();
			data[i*8+6] = "" + temp.getTime();
			data[i*8+7] = "" + temp.getAmount();
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
			ret += ",[" + entry.getKey() + "," + entry.getValue().getTotalValue() + "]";
		}
		return ret;
	}
	
	/**
	 * 
	 * @param timeFrame
	 * @return
	 */
	public String portfolioDataWithCoins(String timeFrame) {
		List<timeValue> overAll = this.portfolioTrend(timeFrame);
		List<List<Candlestick>> coinData = Collections.synchronizedList(new ArrayList<List<Candlestick>>());
		String ret = "[";
		for (Map.Entry<String,Position> entry : coins.entrySet()){
			coinData.add(entry.getValue().getCoin().getDataList(timeFrame));
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
		return ret;
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
	
	public double getPercentChange() {
		double totalBuy = 0;
		double totalCurrent = 0;
		for (Map.Entry<String,Position> entry : coins.entrySet()) {
			Position temp = entry.getValue();
			totalBuy += temp.getTotalValue();
			totalCurrent += temp.getAmount()*temp.getCurrentPrice();
		}
		return totalCurrent/totalBuy;
	}
	
}
