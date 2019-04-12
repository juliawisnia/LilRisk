package coinData;

import java.util.Collections;
import java.util.List;

import com.binance.api.client.domain.market.Candlestick;

public class CoinClass {
	private String coinName;
	private List<Candlestick> coinHourly;
	private List<Candlestick> coinDaily;
	private List<Candlestick> coinWeekly;
	private List<Candlestick> coinMonthly;
	private double currentPrice;
	
	public CoinClass(String coinName, List<Candlestick> hours, List<Candlestick> days, List<Candlestick> weeks, List<Candlestick> months, double currentPrice) {
		this.coinName = coinName;
		this.coinHourly = Collections.synchronizedList(hours);
		this.coinDaily = Collections.synchronizedList(days);
		this.coinWeekly = Collections.synchronizedList(weeks);
		this.coinMonthly = Collections.synchronizedList(months);
		this.currentPrice = currentPrice;
	}
	
	public String getName() {
		return coinName;
	}
	
	
	/**
	 * Updates the data for the given time frame
	 * 
	 * 
	 * @param data: list of candle data for the coin, while not checked it should be the
	 * same time frame as the timeFrame string given
	 * @param timeFrame: time frame of the data. Choose from: hours, days, weeks, months. 
	 * This is the time in between each candle
	 */
	public void updateList(List<Candlestick> data, String timeFrame) {
		if(timeFrame.equalsIgnoreCase("hours")) {
			this.coinHourly = Collections.synchronizedList(data);
		}
		else if(timeFrame.equalsIgnoreCase("days")) {
			this.coinDaily = Collections.synchronizedList(data);	
		}
		else if(timeFrame.equalsIgnoreCase("weeks")) {
			this.coinWeekly = Collections.synchronizedList(data);
		}
		else if(timeFrame.equalsIgnoreCase("months")) {
			this.coinMonthly = Collections.synchronizedList(data);
		}
		else {
			System.out.println("Error: timeFrame input must be one of the following: hours, days, weeks, months");
		}
	}
	
	/**
	 * give the data for the trend graph on the front end
	 * 
	 * @param timeFrame: the time frame wanted for the data
	 * @return: a string of the data to be used in the front end for graphs
	 */
	public String trend(String timeFrame) {
		if(timeFrame.equalsIgnoreCase("hours")) {
			return listToString(coinHourly);
		}
		else if(timeFrame.equalsIgnoreCase("days")) {
			return listToString(coinDaily);
		}
		else if(timeFrame.equalsIgnoreCase("weeks")) {
			return listToString(coinWeekly);
		}
		else if(timeFrame.equalsIgnoreCase("months")) {
			return listToString(coinMonthly);
		}
		else {
			System.out.println("Error: timeFrame input must be one of the following: hours, days, weeks, months");
			return "";
		}
	}
	
	/**
	 * turns the data in one of the lists into the format used by the front end
	 * 
	 * @param data: return a string representation of the data that can be used
	 * in java script for making the graphs
	 * @return a string that is usable in java script
	 */
	private String listToString(List<Candlestick> data) {
		String ret = "[";
		int dataLength = data.size();
		if(dataLength != 0) {
			ret += "[0," + data.get(0).getOpen() + "]";
		}
		for(int i = 1; i < dataLength; i++) {
			ret += ",[" + i + "," + data.get(i).getOpen() + "]";
		}
		return ret + "]";
	}
	
	/**
	 * gives the current price of this coin
	 * 
	 * @return the current price of this coin
	 */
	public double getCurrentPrice() {
		return currentPrice;
	}
	
	public void setCurrentPrice(double price) {
		this.currentPrice = price;
	}
	
	/**
	 * 
	 * @return the hourly list
	 */
	public List<Candlestick> getHourly(){
		return coinHourly;
	}
	
	/**
	 * 
	 * @return the daily list
	 */
	public List<Candlestick> getDaily(){
		return coinDaily;
	}

	/**
	 * 
	 * @return the weekly list
	 */
	public List<Candlestick> getWeekly(){
		return coinWeekly;
	}
	
	/**
	 * 
	 * @return the monthly list
	 */
	public List<Candlestick> getMonthly(){
		return coinMonthly;
	}
	
	
	public void setHourly(List<Candlestick> data){
		this.coinHourly = data;
	}
	
	
	public void setDaily(List<Candlestick> data){
		this.coinDaily = data;
	}

	
	public void setWeekly(List<Candlestick> data){
		this.coinWeekly = data;
	}
	
	
	public void setMonthly(List<Candlestick> data){
		this.coinMonthly = data;
	}
}
