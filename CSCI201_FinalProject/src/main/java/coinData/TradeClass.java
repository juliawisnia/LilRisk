package coinData;

import java.util.ArrayList;
import java.util.List;

public class TradeClass {
	
	Position pos;
	double avgSellPrice;
	long time;
	
	public TradeClass(Position pos, double avgSellPrice) {
		this.pos = pos;
		this.avgSellPrice = avgSellPrice;
		this.time = System.currentTimeMillis();
	}
	
	public TradeClass(Position pos, double avgSellPrice, long time) {
		this.pos = pos;
		this.avgSellPrice = avgSellPrice;
		this.time = time;
	}
	
	public String getCoin() {
		return pos.getName();
	}
	
	public Position getPosition() {
		return pos;
	}
	
	public double getAmount() {
		return pos.getAmount();
	}
	
	public double getAvgBuyPrice() {
		return pos.getAvgBuy();
	}
	
	public double getAvgSellPrice() {
		return avgSellPrice;
	}
	
	public long getTime() {
		return time;
	}
	
	public void setAvgSellPrice(double avgSellPrice) {
		this.avgSellPrice = avgSellPrice;
	}
	
	public void setTime(long time) {
		this.time = time;
	}
	
	public double absoluteDifference() {
		return (this.avgSellPrice-this.pos.getAvgBuy())*this.pos.getAmount();
	}
	
	public List<timeValue> timeValueRange(String timeFrame) {
		List<timeValue> timeValueList = new ArrayList<timeValue>();
		List<timeValue> temp = pos.timeValueData(timeFrame);
		double profit = 0;
		for (int i = 0; i < temp.size(); i++) {
			if (temp.get(i).getTime() < time) {
				timeValueList.add(temp.get(i));
				profit = temp.get(i).getValue();
			}
			else {
				timeValue tv = new timeValue(temp.get(i).getTime(), profit);
				timeValueList.add(tv);
			}
		}
		return timeValueList;
	}
}

