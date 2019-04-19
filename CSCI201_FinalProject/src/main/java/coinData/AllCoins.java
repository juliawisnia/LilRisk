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
	
	public static int getNumCoins() {
		return coins.size();
	}
	
	public static String[] allCoinsData() {
		String ret[] = new String[coins.size()*4];
		int i= 0;
		for (Map.Entry<String,CoinClass> entry : coins.entrySet()) {
			ret[i*4] = entry.getValue().getName();
			ret[i*4+1] = CoinNamesMap.symbol2Name(entry.getValue().getName());
			ret[i*4+2] = "" + entry.getValue().getCurrentPrice();
			ret[i*4+3] = "" + entry.getValue().getDayPercentChange();
			i++;
		}
		return ret;
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
