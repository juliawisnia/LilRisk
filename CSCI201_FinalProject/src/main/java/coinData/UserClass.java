package coinData;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.Lock;

import com.binance.api.client.BinanceApiClientFactory;
import com.binance.api.client.BinanceApiRestClient;
import com.binance.api.client.domain.market.Candlestick;
import com.binance.api.client.domain.market.CandlestickInterval;

public class UserClass {
	private static Map<String, PortfolioClass> portfolios = Collections.synchronizedMap(new Hashtable<String, PortfolioClass>());
	private static Lock lock;
	
	public UserClass() {
		UserThread userThread = new UserThread();
		userThread.initialize();
		userThread.start();
		Thread updater = new PriceUpdater();
		updater.start();
	}
	
	public static void main(String [] args) {
		UserThread userThread = new UserThread();
		
	}

	public String[] coinTrends(String coins[]) {
		System.out.println("hello");
		String key = "CFQvKQ9Xuf7L6mf8i7qqCoDmrK9C6XzGibUWXvTB4nagC3OblBlMTj49BNHV3qjN";
		String secret = "PTJVaWQd9DCW2ysn7ATdLf1T9F8eheEe29mEVfIx9BML92N1dC95nk7jfn8tFplM";
		BinanceApiClientFactory factory = BinanceApiClientFactory.newInstance(key, secret);
		BinanceApiRestClient client = factory.newRestClient();
		
		String values[] = new String[coins.length*2 + 1];
		for(int i = 0; i < coins.length; i++) {
			values[2*i] = coins[i];
			String percent = client.get24HrPriceStatistics(coins[i]).getPriceChangePercent();
			values[2*i + 1] = percent.substring(0, percent.indexOf('.') + 3);
		}
		values[coins.length*2] = trend(coins);
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
		if(coins.length != 0) {
			ret += "[0";
			for(int i = 0; i < coinValues.size(); i++) {
				ret += "," + coinValues.get(i).get(0).getOpen().substring(0, coinValues.get(i).get(0).getOpen().indexOf('.'));
			}
			ret += "]";
		}
		for(int j = 0; j < coinValues.get(0).size(); j++) {
			ret += ",[" + j;
			for(int i = 0; i < coinValues.size(); i++) {
				ret += "," + coinValues.get(i).get(j).getOpen().substring(0, coinValues.get(i).get(j).getOpen().indexOf('.'));
			}
			ret += "]";
		}
			
		ret += "]";
		
		System.out.println("hello");
		return ret;
	}
}



