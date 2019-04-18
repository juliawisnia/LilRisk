package coinData;

import com.binance.api.client.BinanceApiClientFactory;
import com.binance.api.client.BinanceApiRestClient;

public class PriceUpdater extends Thread{
	
	public void run() {
		String key = "CFQvKQ9Xuf7L6mf8i7qqCoDmrK9C6XzGibUWXvTB4nagC3OblBlMTj49BNHV3qjN";
		String secret = "PTJVaWQd9DCW2ysn7ATdLf1T9F8eheEe29mEVfIx9BML92N1dC95nk7jfn8tFplM";
		BinanceApiClientFactory factory = BinanceApiClientFactory.newInstance(key, secret);
		BinanceApiRestClient client = factory.newRestClient();
		
		String coinNames[] = {"BTCUSDT", "ETHUSDT", "BNBUSDT", "NEOUSDT", "LTCUSDT", "QTUMUSDT", "ADAUSDT", "XRPUSDT", "EOSUSDT", "IOTAUSDT", "XLMUSDT", "ONTUSDT", "TRXUSDT", "ETCUSDT", "ICXUSDT", "NULSUSDT", "VETUSDT", "PAXUSDT", "BCHABCUSDT", "BCHSVUSDT", "LINKUSDT", "WAVESUSDT", "BTTUSDT",  "ONGUSDT", "HOTUSDT", "ZILUSDT", "ZRXUSDT", "FETUSDT", "BATUSDT", "XMRUSDT", "ZECUSDT", "IOSTUSDT", "CELRUSDT", "DASHUSDT", "NANOUSDT", "OMGUSDT"};
		
		while(true) {
			try {
				Thread.sleep(10000);
				for(int i = 0; i < coinNames.length; i++) {
					AllCoins.updatePrice(coinNames[i], Double.parseDouble(client.getPrice(coinNames[i]).getPrice()));
				}
			}
			catch(InterruptedException ie) {
				System.out.println(ie.getMessage());
			}
		}
	}
}
