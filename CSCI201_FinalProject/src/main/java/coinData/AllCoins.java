package coinData;

import java.util.Collections;
import java.util.Hashtable;
import java.util.Map;

public class AllCoins {
	private static Map<String, CoinClass> coins = Collections.synchronizedMap(new Hashtable<String, CoinClass>());
	
	public AllCoins() {
	}
	
	public static CoinClass getCoin(String coin) {
		return coins.get(coin);
	}
	
	public static void addCoin(CoinClass coin) {
		coins.put(coin.getName(), coin);
	}
	
	public static void updateCoin(CoinClass coin) {
		coins.get(coin.getName()).setHourly(coin.getHourly());
		coins.get(coin.getName()).setDaily(coin.getDaily());
		coins.get(coin.getName()).setWeekly(coin.getWeekly());
		coins.get(coin.getName()).setMonthly(coin.getMonthly());
	}
	
	public static void updatePrice(String coin, double price) {
		coins.get(coin).setCurrentPrice(price);
	}
}
