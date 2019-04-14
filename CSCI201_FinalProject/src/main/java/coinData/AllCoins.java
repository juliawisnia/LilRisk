package coinData;

import java.util.Collections;
import java.util.Hashtable;
import java.util.Map;

public class AllCoins {
	private static Map<String, CoinClass> coins = Collections.synchronizedMap(new Hashtable<String, CoinClass>());
	
	public AllCoins() {
	}
	
	/**
	 * 
	 * @param coin
	 * @return
	 */
	public static CoinClass getCoin(String coin) {
		return coins.get(coin);
	}
	
	/**
	 * 
	 * @param coin
	 */
	public static void addCoin(CoinClass coin) {
		coins.put(coin.getName(), coin);
	}
	
	/**
	 * 
	 * @param coin
	 */
	public static void updateCoin(CoinClass coin) {
		coins.get(coin.getName()).setDay(coin.getDay());
		coins.get(coin.getName()).setWeek(coin.getWeek());
		coins.get(coin.getName()).setMonth(coin.getMonth());
		coins.get(coin.getName()).setMonth6(coin.getMonth6());
		coins.get(coin.getName()).setYear(coin.getYear());
	}
	
	/**
	 * 
	 * @param coin
	 * @param price
	 */
	public static void updatePrice(String coin, double price) {
		coins.get(coin).setCurrentPrice(price);
	}
}
