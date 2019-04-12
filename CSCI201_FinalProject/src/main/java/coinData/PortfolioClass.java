package coinData;


import java.util.Collections;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Vector;



public class PortfolioClass {
	private String portfolioName;
	private Map<String, Position> coins;
	private Vector<TradeClass> tradeHistory;
	private double extraMunz;
	private double spentMunz;

	public PortfolioClass(String portfolioName) {
		this.portfolioName = portfolioName;
		this.coins = Collections.synchronizedMap(new Hashtable<String, Position>());
		this.tradeHistory = new Vector<TradeClass>();
		this.extraMunz = 0;
		this.spentMunz = 0;
	}
	
	public void recordTrade(String coin, double avgBuyPrice, double avgSellPrice, double amount, long time) {
		TradeClass executedTrade = new TradeClass(coin, avgBuyPrice, avgSellPrice, amount, time);
		tradeHistory.add(executedTrade);
		extraMunz += ((avgSellPrice - avgBuyPrice) * amount);
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
			Position temp = new Position(coin, amount);
			coins.put(coin, temp);
			spent = temp.getAvgBuy();
			
		}
		spendMunz(spent);
	}
	
	
	public void sell(Position pos, double avgSellPrice) {
		recordTrade(pos.getName(), pos.getAvgBuy(), avgSellPrice, pos.getAmount(), System.currentTimeMillis());
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
	
	/**
	 * give the trend of the data for this portfolio on the given time frame
	 * 
	 * @param timeFrame: string of the time frame that you want. Choices: 
	 * min5, halfHour, hours, days
	 * @return a string that can be used in java script on the front end
	 */
	public String trend(String timeFrame) {
		Set<String> keys = coins.keySet();
		Object[] keyArray = keys.toArray();
		List<Position> coins = new Vector<Position>();
		for(int i = 0; i < keyArray.length; i++) {
			coins.add(this.coins.get(keyArray[i].toString()));
		}
		return listToString(coins, timeFrame);
	}
	
	
	/**
	 * 
	 * @param timeFrame
	 * @return
	 */
	public List<timeValue> portfolioTrend(String timeFrame){
		return null;
	}
	
	/**
	 * 
	 * @param coins
	 * @param timeFrame
	 * @return
	 */
	private String listToString(List<Position> coins, String timeFrame) {
		String ret = "[";
		int dataLength = coins.size();
		if(dataLength != 0) {
			ret += "[0";
			double change = 0;
			for(int i = 0; i < dataLength; i++) {
				change += Double.parseDouble(coins.get(i).trendData(timeFrame).get(0).getOpen())-coins.get(i).getAvgBuy();
			}
			ret += "," + change + "]";
		}
		int coinsLength = coins.get(0).trendData(timeFrame).size();
		for(int i = 1; i < coinsLength; i++) {
			ret += ",[" + i;
			double change = 0;
			for(int j = 0; j < dataLength; j++) {
				change += Double.parseDouble(coins.get(j).trendData(timeFrame).get(i).getOpen())-coins.get(j).getAvgBuy();
			}
			ret += "," + change + "]";
		}
		return ret + "]";
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
}


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
