package coinData;

public class TradeClass {
	
	double currentBalance;
	double tradingPositionDollarAmount;
	double avgBuyPrice;
	double avgSellPrice;
	double positionAmount;
	double percentageGain;
	double priceGain;
	
	public TradeClass(double avgBuyPrice, double avgSellPrice) {
		this.tradingPositionDollarAmount = 0.00;
		this.avgBuyPrice = avgBuyPrice;
		this.avgSellPrice = avgSellPrice;
		this.positionAmount = 0.00;
		this.percentageGain = 0.00;
		this.priceGain = 0.00;	
	}
	
	public double calculateTradingPosition() {
		return (this.avgBuyPrice*this.tradingPositionDollarAmount);
	}
	
	public double calculatePercentageGain() {
		return ((this.avgSellPrice*(this.positionAmount-(this.positionAmount*0.001))) - (this.tradingPositionDollarAmount+(this.tradingPositionDollarAmount*0.001))) / this.tradingPositionDollarAmount;
	}
	
	public double calculatePriceGain() {
		double calculatedResult = this.calculatePriceGain();
		return (calculatedResult*this.positionAmount);
	}
	
	public double calculatePrincipalCapital() {
		return (currentBalance+this.calculatePriceGain());
	}
}
