
public class CandlestickClass {

	int openTime;
	int closeTime;
	int candleOpen;
	int candleHigh;
	int candleLow;
	int candleClose;
	int candleVolume;
	int quoteAssetVolume;
	int numberTrade;
	int takerBuyBaseAssetVol;
	int takerBuyQuoteAssetVol;
	
	public CandlestickClass(int openTime, int closeTime, int candleOpen, int candleHigh, int candleLow, int candleClose,
			int candleVolume, int quoteAssetVolume, int numberTrade, int takerBuyBaseAssetVol, int takerBuyQuoteAssetVol) {
        this.openTime = openTime;
        this.closeTime = closeTime;
        this.candleOpen = candleOpen;
        this.candleHigh = candleHigh;
        this.candleLow = candleLow;
        this.candleClose = candleClose;
        this.candleVolume = candleVolume;
        this.quoteAssetVolume = quoteAssetVolume;
        this.numberTrade = numberTrade;
        this.takerBuyBaseAssetVol = takerBuyBaseAssetVol;
        this.takerBuyQuoteAssetVol = takerBuyQuoteAssetVol;
	}
			
}
