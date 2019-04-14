package coinData;

import java.util.Collections;
import java.util.List;

import com.binance.api.client.domain.market.Candlestick;

public class CoinClass {
	private String coinName;
	private List<Candlestick> day;
	private List<Candlestick> week;
	private List<Candlestick> month;
	private List<Candlestick> month6;
	private List<Candlestick> year;
	private double currentPrice;
	private double dayPercentChange;
	
	public CoinClass(String coinName, List<Candlestick> day, List<Candlestick> week, List<Candlestick> month, List<Candlestick> month6,List<Candlestick> year, double currentPrice, double dayPercentChange) {
		this.coinName = coinName;
		this.day = Collections.synchronizedList(day);
		this.week = Collections.synchronizedList(week);
		this.month = Collections.synchronizedList(month);
		this.month6 = Collections.synchronizedList(month6);
		this.year = Collections.synchronizedList(year);
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
		if(timeFrame.equalsIgnoreCase("day")) {
			this.day = Collections.synchronizedList(data);
		}
		else if(timeFrame.equalsIgnoreCase("week")) {
			this.week = Collections.synchronizedList(data);	
		}
		else if(timeFrame.equalsIgnoreCase("month")) {
			this.month = Collections.synchronizedList(data);
		}
		else if(timeFrame.equalsIgnoreCase("month6")) {
			this.month6 = Collections.synchronizedList(data);
		}
		else if(timeFrame.equalsIgnoreCase("year")) {
			this.year = Collections.synchronizedList(data);
		}
		else {
			System.out.println("Error: timeFrame input must be one of the following: hours, days, weeks, months");
		}
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
	public List<Candlestick> getDataList(String timeFrame) {
		if(timeFrame.equalsIgnoreCase("day")) {
			return day;
		}
		else if(timeFrame.equalsIgnoreCase("week")) {
			return week;	
		}
		else if(timeFrame.equalsIgnoreCase("month")) {
			return month;
		}
		else if(timeFrame.equalsIgnoreCase("month6")) {
			return month6;
		}
		else if(timeFrame.equalsIgnoreCase("year")) {
			return year;
		}
		else {
			System.out.println("Error: timeFrame input must be one of the following: hours, days, weeks, months");
			return null;
		}
	}
	
	/**
	 * give the data for the trend graph on the front end
	 * 
	 * @param timeFrame: the time frame wanted for the data
	 * @return: a string of the data to be used in the front end for graphs
	 */
	public String trend(String timeFrame) {
		if(timeFrame.equalsIgnoreCase("day")) {
			return listToString(day);
		}
		else if(timeFrame.equalsIgnoreCase("week")) {
			return listToString(week);
		}
		else if(timeFrame.equalsIgnoreCase("month")) {
			return listToString(month);
		}
		else if(timeFrame.equalsIgnoreCase("month6")) {
			return listToString(month6);
		}
		else if(timeFrame.equalsIgnoreCase("year")) {
			return listToString(year);
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
	public List<Candlestick> getDay(){
		return day;
	}
	
	/**
	 * 
	 * @return the daily list
	 */
	public List<Candlestick> getWeek(){
		return week;
	}

	/**
	 * 
	 * @return the halfHour list
	 */
	public List<Candlestick> getMonth(){
		return month;
	}
	
	/**
	 * 
	 * @return the monthly list
	 */
	public List<Candlestick> getMonth6(){
		return month6;
	}
	
	/**
	 * 
	 * @return the monthly list
	 */
	public List<Candlestick> getYear(){
		return year;
	}
	
	/**
	 * 
	 * @param data
	 */
	public void setDay(List<Candlestick> data){
		this.day = data;
	}
	
	/**
	 * 
	 * @param data
	 */
	public void setWeek(List<Candlestick> data){
		this.week = data;
	}

	/**
	 * 
	 * @param data
	 */
	public void setMonth(List<Candlestick> data){
		this.month = data;
	}
	
	/**
	 * 
	 * @param data
	 */
	public void setMonth6(List<Candlestick> data){
		this.month6 = data;
	}
	
	/**
	 * 
	 * @param data
	 */
	public void setYear(List<Candlestick> data){
		this.year = data;
	}
}
