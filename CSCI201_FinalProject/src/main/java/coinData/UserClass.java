package coinData;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.locks.Lock;

import com.binance.api.client.BinanceApiClientFactory;
import com.binance.api.client.BinanceApiRestClient;
import com.binance.api.client.domain.market.Candlestick;
import com.binance.api.client.domain.market.CandlestickInterval;

public class UserClass {
	private static Map<String, PortfolioClass> portfolios = Collections.synchronizedMap(new Hashtable<String, PortfolioClass>());
	private String username;
	
	public UserClass() {
		UserThread userThread = new UserThread();
		userThread.initialize();
		userThread.start();
		Thread updater = new PriceUpdater();
		updater.start();
		this.username = "";
	}

	public String[] coinTrends(String coins[]) {
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
		for(int j = 1; j < coinValues.get(0).size(); j++) {
			ret += ",[" + j;
			for(int i = 0; i < coinValues.size(); i++) {
				if(i < coinValues.get(i).size()) {
					ret += "," + coinValues.get(i).get(j).getOpen().substring(0, coinValues.get(i).get(j).getOpen().indexOf('.'));
				}
				else {
					ret += "," + 0;
				}
			}
			ret += "]";
		}
			
		ret += "]";
		
		System.out.println("hello");
		return ret;
	}
	
	public String trends(String timeFrame) {
		String ret = "[";
		List<List<timeValue>> ports = Collections.synchronizedList(new ArrayList<List<timeValue>>());
		Set<String> keys = portfolios.keySet();
		Iterator<String> iter = keys.iterator();
		while(iter != null) {
			ports.add(portfolios.get(iter.next()).portfolioTrend(timeFrame));
		}
		int longest = 0;
		for(int i = 0; i < ports.size(); i++) {
			if(ports.get(i).size() > longest) {
				longest = ports.get(i).size();
			}
		}
		if(ports.get(0).size() != 0) {
			ret += "[0";
			for(int i = 0; i < ports.size(); i++) {
				if(ports.get(i).size()-longest == 0) {
					ret += "," + (int) ports.get(i).get(0).getValue();
				}
				else {
					ret += "," + 0;
				}
				
			}
			ret += "]";
		}
		for(int j = 1; j < ports.get(0).size(); j++) {
			ret += ",[" + j;
			for(int i = 0; i < ports.size(); i++) {
				if(ports.get(i).size()-longest > 0) {
					ret += "," + (int) ports.get(i).get(j).getValue();
				}
				else {
					ret += "," + 0;
				}
				
			}
			ret += "]";
		}
		ret += "]";
		return ret;
	}
	
	public List<timeValue> getPorfolioTrends(String timeFrame) {
		List<timeValue> ret = Collections.synchronizedList(new ArrayList<timeValue>());
		List<List<timeValue>> ports = Collections.synchronizedList(new ArrayList<List<timeValue>>());
		Set<String> keys = portfolios.keySet();
		Iterator<String> iter = keys.iterator();
		while(iter != null) {
			ports.add(portfolios.get(iter.next()).portfolioTrend(timeFrame));
			
		}
		int longest = 0;
		for(int i = 0; i < ports.size(); i++) {
			if(ports.get(i).size() > longest) {
				longest = ports.get(i).size();
			}
		}
		for(int i = 0; i < ports.size(); i++) {
			for(int j = 0; j < longest; i++) {
				double total = 0;
				long time = 0;
				int size = longest - ports.get(i).size();
				if(j >= size) {
					time = ports.get(i).get(j).getTime();
					total += ports.get(i).get(j).getValue();
				}
				ret.add(new timeValue(time, total));
			}
				
		}
		return ret;
	}
	
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getUsername() {
		return username;
	}
}



