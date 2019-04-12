package coinData;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import java.util.concurrent.locks.Lock;

import com.binance.api.client.BinanceApiClientFactory;
import com.binance.api.client.BinanceApiRestClient;
import com.binance.api.client.domain.market.Candlestick;
import com.binance.api.client.domain.market.CandlestickInterval;

public class UserClass {
	private static Map<String, PortfolioClass> portfolios = Collections.synchronizedMap(new Hashtable<String, PortfolioClass>());
	private static Lock lock;
	
	public UserClass() {
	}
	
	public static void main(String [] args) {
		UserThread userThread = new UserThread();
		userThread.initialize();
		userThread.start();
		Thread updater = new PriceUpdater();
		updater.start();
		
		
	}
	
	/*
	public void trend(String portfolios[], String timeFrame) {
		String ret = "[";
		int dataLength = coins.size();
		if(dataLength != 0) {
			ret += "[0";
			double change = 0;
			for(int i = 0; i < dataLength; i++) {
				change += Double.parseDouble(coins.get(i).trendData(timeFrame).get(0).getOpen())-coins.get(i).getAvgBuy();
			}
			ret += "," + change + "]";
		}
		int coinsLength = coins.get(0).trendData(timeFrame).size();
		for(int i = 1; i < coinsLength; i++) {
			ret += ",[" + i;
			double change = 0;
			for(int j = 0; j < dataLength; j++) {
				change += Double.parseDouble(coins.get(j).trendData(timeFrame).get(i).getOpen())-coins.get(j).getAvgBuy();
			}
			ret += "," + change + "]";
		}
		return ret + "]";
	}
	*/
	
	public String[] coinTrends(String coins[]) {
		String key = "CFQvKQ9Xuf7L6mf8i7qqCoDmrK9C6XzGibUWXvTB4nagC3OblBlMTj49BNHV3qjN";
		String secret = "PTJVaWQd9DCW2ysn7ATdLf1T9F8eheEe29mEVfIx9BML92N1dC95nk7jfn8tFplM";
		BinanceApiClientFactory factory = BinanceApiClientFactory.newInstance(key, secret);
		BinanceApiRestClient client = factory.newRestClient();
		
		String values[] = new String[coins.length*2 + 1];
		for(int i = 0; i < coins.length; i++) {
			values[2*i] = coins[i];
			values[2*i + 1] = client.getPrice(coins[i]).getPrice();
		}
		values[coins.length*2 + 1] = trend(coins);
		return values;
	}
	
	private String trend(String coins[]) {
		String key = "CFQvKQ9Xuf7L6mf8i7qqCoDmrK9C6XzGibUWXvTB4nagC3OblBlMTj49BNHV3qjN";
		String secret = "PTJVaWQd9DCW2ysn7ATdLf1T9F8eheEe29mEVfIx9BML92N1dC95nk7jfn8tFplM";
		BinanceApiClientFactory factory = BinanceApiClientFactory.newInstance(key, secret);
		BinanceApiRestClient client = factory.newRestClient();
		
		List<List<Candlestick>> coinValues = Collections.synchronizedList(new ArrayList<List<Candlestick>>());
		for(int i = 0; i < coins.length; i++) {
			coinValues.add(client.getCandlestickBars(coins[i], CandlestickInterval.HALF_HOURLY));
		}
		String ret = "[";
		if() {
			ret += "[0";
			for(int i = 0; i < coinValues.size(); i++) {
				
			}
		}
		for(int j = 0; j < coinValues.get(0).size(); j++) {
			ret += ",[" + j;
			for(int i = 0; i < coinValues.size(); i++) {
				
			}
		}
			
		ret += "[";
	}
}

class Coinmap{
	private Map<String, String> symbol2Names = Collections.synchronizedMap(new Hashtable<String, String>());
	private Map<String, String> name2Symbols = Collections.synchronizedMap(new Hashtable<String, String>());
	
	public Coinmap() {
		
	}
	
	public String symbol2Name(String symbol) {
		
	}
	
	public String name2Symbol(String symbol) {
		
	}
}
