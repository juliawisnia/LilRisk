package coinData;

import java.util.Collections;
import java.util.Hashtable;
import java.util.Map;

public class UserClass {
	private static Map<String, PortfolioClass> portfolios = Collections.synchronizedMap(new Hashtable<String, PortfolioClass>());
	
	public UserClass() {
	}
	
	public static void main(String [] args) {
		UserThread userThread = new UserThread();
		userThread.initialize();
		userThread.start();
		System.out.println("After");
		Thread updater = new PriceUpdater();
		updater.start();
		
		portfolios.put("My First Portfolio",new PortfolioClass("My First Portfolio"));
		
		portfolios.get("My First Portfolio").buy("BTCUSDT", 10);
		
		
		while(true) {
			System.out.println("This is the trend: " + portfolios.get("My First Portfolio").trend("hours"));
			try {
			Thread.sleep(100000);
			}
			catch(InterruptedException ie) {
				System.out.println(ie.getMessage());
				
			}
		}
	}
	
	public void trend(String portfolios[]) {
		
	}
}
