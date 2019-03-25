import java.util.Vector;

public class CoinClass {
	
	String coinName;
	Vector<CandlestickClass> coinCandles = new Vector<CandlestickClass>();
	int numberOfCandles = 500;
	
	public CoinClass(String coinName) {
		this.coinName = coinName;
		for (int i = 0; i < numberOfCandles; i++) {
			CandlestickClass newCandle = new CandlestickClass(1,1,1,1,1,1,1,1,1,1,1);
			coinCandles.add(newCandle);
		}
	}
}