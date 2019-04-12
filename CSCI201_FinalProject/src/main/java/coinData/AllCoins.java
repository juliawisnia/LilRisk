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
		coins.get(coin.getName()).setHourly(coin.getHourly());
		coins.get(coin.getName()).setDaily(coin.getDaily());
		coins.get(coin.getName()).setMin5(coin.getMin5());
		coins.get(coin.getName()).setHalfHour(coin.getHalfHour());
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
