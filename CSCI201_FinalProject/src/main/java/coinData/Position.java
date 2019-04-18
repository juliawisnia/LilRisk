package coinData;

import java.util.ArrayList;
import java.util.List;

import com.binance.api.client.domain.market.Candlestick;

public class Position {
	private CoinClass coin;
	private double avgBuy;
	private double amount;
	private long time;
	
	public Position(String coin, double amount, long time) {
		this.coin = AllCoins.getCoin(coin);
		this.avgBuy = this.coin.getCurrentPrice();
		this.amount = amount;
		this.time = time;
	}
	
	public Position(String coin, double avgBuy, long time, double amount) {
		this.coin = AllCoins.getCoin(coin);
		this.avgBuy = avgBuy;
		this.time = time;;
		this.amount = amount;
	}

	public double getTotalValue() {
		return avgBuy*amount;
	}
	
	public CoinClass getCoin() {
		return coin;
	}
	
	
	
	/**
	 * 
	 * @return
	 */
	public String getName() {
		return coin.getName();
	}
	
	public double getCurrentPrice() {
		return coin.getCurrentPrice();
	}
	
	/**
	 * 
	 * @param timeFrame
	 * @return
	 */
	public List<Candlestick> trendData(String timeFrame){
		List<Candlestick> ret = coin.getDataList(timeFrame);
		for(int i = 0; i < ret.size(); i++) {
			if(ret.get(i).getOpenTime() < this.time) {
				ret.remove(i);
				i--;
			}
		}
		return ret;
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
	public double buyMore(double amount) {
		double newAvg = coin.getCurrentPrice();
		double ret = newAvg;
		newAvg = ((newAvg*amount)+(avgBuy*this.amount))/(this.amount+amount);
		avgBuy = newAvg;
		this.amount += amount;
		return ret*amount;
	}
	
	/**
	 * 
	 * @return
	 */
	public double getAmount() {
		return amount;
	}
	
	/**
	 * 
	 * @return
	 */
	public double getAvgBuy() {
		return avgBuy;
	}
	
	public long getBuyTime() {
		return time;
	}
	
	/**
	 * 
	 * @param timeFrame
	 * @return
	 */
	public String trend(String timeFrame) {
		return listToString(trendData(timeFrame));
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
	
	
	public List<timeValue> timeValueData(String timeFrame) {
		List<timeValue> returnList = new ArrayList();
		List<Candlestick> ret = coin.getDataList(timeFrame);
		for(int i = 0; i < ret.size(); i++) {
			if(ret.get(i).getOpenTime() < this.time) {
				ret.remove(i);
				i--;
			}
			else {
				timeValue temp = new timeValue(ret.get(i).getOpenTime(), Double.parseDouble(ret.get(i).getOpen())-avgBuy);
				returnList.add(temp);
			}
		}
		return returnList;
	}
}

