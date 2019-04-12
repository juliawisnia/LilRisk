package coinData;

import java.util.List;

import com.binance.api.client.domain.market.Candlestick;

public class Position {
	private CoinClass coin;
	private double avgBuy;
	private int amount;
	private long time;
	
	public Position(String coin, int amount) {
		this.coin = AllCoins.getCoin(coin);
		this.avgBuy = this.coin.getCurrentPrice();
		this.amount = amount;
	}
	
	/**
	 * 
	 * @return
	 */
	public String getName() {
		return coin.getName();
	}
	
	/**
	 * 
	 * @param timeFrame
	 * @return
	 */
	public List<Candlestick> trendData(String timeFrame){
		if(timeFrame.equalsIgnoreCase("hours")) {
			List<Candlestick> ret = coin.getHourly();
			/*
			for(int i = 0; i < ret.size(); i++) {
				if(ret.get(i).getOpenTime() < this.time) {
					ret.remove(i);
					i--;
				}
			}
			*/
			return ret;
		}
		else if(timeFrame.equalsIgnoreCase("days")) {
			List<Candlestick> ret = coin.getDaily();
			for(int i = 0; i < ret.size(); i++) {
				if(ret.get(i).getOpenTime() < this.time) {
					ret.remove(i);
					i--;
				}
			}
			return ret;
		}
		else if(timeFrame.equalsIgnoreCase("weeks")) {
			List<Candlestick> ret = coin.getWeekly();
			for(int i = 0; i < ret.size(); i++) {
				if(ret.get(i).getOpenTime() < this.time) {
					ret.remove(i);
					i--;
				}
			}
			return ret;
		}
		else if(timeFrame.equalsIgnoreCase("months")) {
			List<Candlestick> ret = coin.getMonthly();
			for(int i = 0; i < ret.size(); i++) {
				if(ret.get(i).getOpenTime() < this.time) {
					ret.remove(i);
					i--;
				}
			}
			return ret;
		}
		else {
			System.out.println("Error: timeFrame input must be one of the following: hours, days, weeks, months");
			return null;
		}
	}
	
	/**
	 * 
	 * @return
	 */
	public double percentDifference() {
		return (avgBuy/coin.getCurrentPrice())-1;
	}
	
	/**
	 * 
	 * @return
	 */
	public double absoluteDifference() {
		return (avgBuy-coin.getCurrentPrice())*amount;
	}
	
	/**
	 * 
	 * @param amount
	 */
	public void buyMore(int amount) {
		double newAvg = coin.getCurrentPrice();
		newAvg = ((newAvg*amount)+(avgBuy*this.amount))/(this.amount+amount);
		avgBuy = newAvg;
		this.amount += amount;
	}
	
	/**
	 * 
	 * @return
	 */
	public int getAmount() {
		return amount;
	}
	
	/**
	 * 
	 * @return
	 */
	public double getAvgBuy() {
		return avgBuy;
	}
	
	/**
	 * 
	 * @param timeFrame
	 * @return
	 */
	public String trend(String timeFrame) {
		if(timeFrame.equalsIgnoreCase("hours")) {
			return listToString(trendData(timeFrame));
		}
		else if(timeFrame.equalsIgnoreCase("days")) {
			return listToString(trendData(timeFrame));
		}
		else if(timeFrame.equalsIgnoreCase("weeks")) {
			return listToString(trendData(timeFrame));
		}
		else if(timeFrame.equalsIgnoreCase("months")) {
			return listToString(trendData(timeFrame));
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
			double change = Double.parseDouble(data.get(0).getOpen())-avgBuy;
			ret += "[0," + change + "]";
		}
		for(int i = 1; i < dataLength; i++) {
			double change = Double.parseDouble(data.get(i).getOpen())-avgBuy;
			ret += ",[" + i + "," + change + "]";
		}
		return ret + "]";
	}
}
