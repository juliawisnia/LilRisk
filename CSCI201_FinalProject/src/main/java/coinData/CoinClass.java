package coinData;

import java.util.Collections;
import java.util.List;

import com.binance.api.client.domain.market.Candlestick;

public class CoinClass {
	private String coinName;
	private List<Candlestick> coinMin5;
	private List<Candlestick> coinHalfHour;
	private List<Candlestick> coinHourly;
	private List<Candlestick> coinDaily;
	private double currentPrice;
	
	public CoinClass(String coinName, List<Candlestick> min5, List<Candlestick> halfHour, List<Candlestick> hour, List<Candlestick> day, double currentPrice) {
		this.coinName = coinName;
		this.coinMin5 = Collections.synchronizedList(min5);
		this.coinHalfHour = Collections.synchronizedList(halfHour);
		this.coinHourly = Collections.synchronizedList(hour);
		this.coinDaily = Collections.synchronizedList(day);
		this.currentPrice = currentPrice;
	}
	
	/**
	 * 
	 * @return
	 */
	public String getName() {
		return coinName;
	}
	
	
	/**
	 * Updates the data for the given time frame
	 * 
	 * 
	 * @param data: list of candle data for the coin, while not checked it should be the
	 * same time frame as the timeFrame string given
	 * @param timeFrame: time frame of the data. Choose from: min5, halfHour, hours, days. 
	 * This is the time in between each candle
	 */
	public void updateList(List<Candlestick> data, String timeFrame) {
		if(timeFrame.equalsIgnoreCase("min5")) {
			this.coinMin5 = Collections.synchronizedList(data);
		}
		else if(timeFrame.equalsIgnoreCase("halfHour")) {
			this.coinHalfHour = Collections.synchronizedList(data);	
		}
		else if(timeFrame.equalsIgnoreCase("hours")) {
			this.coinHourly = Collections.synchronizedList(data);
		}
		else if(timeFrame.equalsIgnoreCase("days")) {
			this.coinDaily = Collections.synchronizedList(data);
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
		if(timeFrame.equalsIgnoreCase("min5")) {
			return listToString(coinMin5);
		}
		else if(timeFrame.equalsIgnoreCase("halfHour")) {
			return listToString(coinHalfHour);
		}
		else if(timeFrame.equalsIgnoreCase("hours")) {
			return listToString(coinHourly);
		}
		else if(timeFrame.equalsIgnoreCase("days")) {
			return listToString(coinDaily);
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
	
	/**
	 * 
	 * @param price
	 */
	public void setCurrentPrice(double price) {
		this.currentPrice = price;
	}
	
	/**
	 * 
	 * @return the min5 list
	 */
	public List<Candlestick> getMin5(){
		return coinMin5;
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
	 * @return the halfHour list
	 */
	public List<Candlestick> getHalfHour(){
		return coinHalfHour;
	}
	
	/**
	 * 
	 * @return the monthly list
	 */
	public List<Candlestick> getHourly(){
		return coinHourly;
	}
	
	/**
	 * 
	 * @param data
	 */
	public void setHourly(List<Candlestick> data){
		this.coinHourly = data;
	}
	
	/**
	 * 
	 * @param data
	 */
	public void setDaily(List<Candlestick> data){
		this.coinDaily = data;
	}

	/**
	 * 
	 * @param data
	 */
	public void setMin5(List<Candlestick> data){
		this.coinMin5 = data;
	}
	
	/**
	 * 
	 * @param data
	 */
	public void setHalfHour(List<Candlestick> data){
		this.coinHalfHour = data;
	}
}
