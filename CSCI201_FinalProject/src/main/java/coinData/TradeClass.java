package coinData;

public class TradeClass {
	
	String coin;
	int amount;
	double avgBuyPrice;
	double avgSellPrice;
	long time;
	
	public TradeClass(String coin, double avgBuyPrice, double avgSellPrice, int amount, long time) {
		this.coin = coin;
		this.avgBuyPrice = avgBuyPrice;
		this.avgSellPrice = avgSellPrice;
		this.amount = amount;
		this.time = time;
	}
	
	public String getCoin() {
		return coin;
	}
	
	public int getAmount() {
		return amount;
	}
	
	public double getAvgBuyPrice() {
		return avgBuyPrice;
	}
	
	public double getAvgSellPrice() {
		return avgSellPrice;
	}
	
	public long getTime() {
		return time;
	}
	
	public void setCoin(String coin) {
		this.coin = coin;
	}
	
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	public void setAvgBuyPrice(double avgBuyPrice) {
		this.avgBuyPrice = avgBuyPrice;
	}
	
	public void setAvgSellPrice(double avgSellPrice) {
		this.avgSellPrice = avgSellPrice;
	}
	
	public void setTime(long time) {
		this.time = time;
	}
}
