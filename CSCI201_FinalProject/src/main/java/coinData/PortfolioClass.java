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
	
	public PortfolioClass(String portfolioName) {
		this.portfolioName = portfolioName;
		this.coins = Collections.synchronizedMap(new Hashtable<String, Position>());
	}
	
	/**
	 * 
	 * @param position: coin that you want to
	 */
	public void buy(String coin, int amount) {
		if(coins.containsKey(coin)) {
			coins.get(coin).buyMore(amount);
		}
		else {
			coins.put(coin, new Position(coin, amount));
		}
	}
	
	/**
	 * 
	 * @return
	 */
	public String getName() {
		return portfolioName;
	}
	
	/**
	 * give the trend of the data for this portfolio on the given time frame
	 * 
	 * @param timeFrame: string of the time frame that you want. Choices: 
	 * hours, days, weeks, months
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
	 * @param coins
	 * @param timeFrame
	 * @return
	 */
	private String listToString(List<Position> coins, String timeFrame) {
		String ret = "[";
		int dataLength = coins.size();
		if(dataLength != 0) {
			ret += "[0";
			for(int i = 0; i < dataLength; i++) {
				double change = Double.parseDouble(coins.get(i).trendData(timeFrame).get(0).getOpen())-coins.get(i).getAvgBuy();
				ret += "," + change;
			}
			ret += "]";
		}
		int coinsLength = coins.get(0).trendData(timeFrame).size();
		for(int i = 1; i < coinsLength; i++) {
			ret += ",[" + i;
			for(int j = 0; j < dataLength; j++) {
				double change = Double.parseDouble(coins.get(j).trendData(timeFrame).get(i).getOpen())-coins.get(j).getAvgBuy();
				ret += "," + change;
			}
			ret += "]";
		}
		return ret + "]";
	}
}
