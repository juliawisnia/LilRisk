package coinData;

import java.util.Collections;
import java.util.List;

import com.binance.api.client.BinanceApiClientFactory;
import com.binance.api.client.BinanceApiRestClient;
import com.binance.api.client.domain.market.Candlestick;
import com.binance.api.client.domain.market.CandlestickInterval;

public class UserThread extends Thread{
	public void initialize() {
		String key = "CFQvKQ9Xuf7L6mf8i7qqCoDmrK9C6XzGibUWXvTB4nagC3OblBlMTj49BNHV3qjN";
		String secret = "PTJVaWQd9DCW2ysn7ATdLf1T9F8eheEe29mEVfIx9BML92N1dC95nk7jfn8tFplM";
		BinanceApiClientFactory factory = BinanceApiClientFactory.newInstance(key, secret);
		BinanceApiRestClient client = factory.newRestClient();
		
		String coinNames[] = {"BTCUSDT", "ETHUSDT", "BNBUSDT", "BCCUSDT", "NEOUSDT", "LTCUSDT", "QTUMUSDT", "ADAUSDT", "XRPUSDT", "EOSUSDT", "TUSDUSDT", "IOTAUSDT", "XLMUSDT", "ONTUSDT", "TRXUSDT", "ETCUSDT", "ICXUSDT", "VENUSDT", "NULSUSDT", "VETUSDT", "PAXUSDT", "BCHABCUSDT", "BCHSVUSDT", "USDCUSDT", "LINKUSDT", "WAVESUSDT", "BTTUSDT", "USDSUSDT", "ONGUSDT", "HOTUSDT", "ZILUSDT", "ZRXUSDT", "FETUSDT", "BATUSDT", "XMRUSDT", "ZECUSDT", "IOSTUSDT", "CELRUSDT", "DASHUSDT", "NANOUSDT", "OMGUSDT"};
		for(int i = 0; i < coinNames.length; i++) {
			List<Candlestick> weekly = Collections.synchronizedList(client.getCandlestickBars(coinNames[i], CandlestickInterval.WEEKLY));
			List<Candlestick> daily = Collections.synchronizedList(client.getCandlestickBars(coinNames[i], CandlestickInterval.DAILY));
			List<Candlestick> hourly = Collections.synchronizedList(client.getCandlestickBars(coinNames[i], CandlestickInterval.ONE_MINUTE));
			List<Candlestick> monthly = Collections.synchronizedList(client.getCandlestickBars(coinNames[i], CandlestickInterval.MONTHLY));
			AllCoins.addCoin(new CoinClass(coinNames[i],hourly,weekly,daily,monthly,Double.parseDouble(client.getPrice(coinNames[i]).getPrice())));
		}
	}
	
	public void run() {
		String key = "CFQvKQ9Xuf7L6mf8i7qqCoDmrK9C6XzGibUWXvTB4nagC3OblBlMTj49BNHV3qjN";
		String secret = "PTJVaWQd9DCW2ysn7ATdLf1T9F8eheEe29mEVfIx9BML92N1dC95nk7jfn8tFplM";
		BinanceApiClientFactory factory = BinanceApiClientFactory.newInstance(key, secret);
		BinanceApiRestClient client = factory.newRestClient();
		
		String coinNames[] = {"BTCUSDT", "ETHUSDT", "BNBUSDT", "BCCUSDT", "NEOUSDT", "LTCUSDT", "QTUMUSDT", "ADAUSDT", "XRPUSDT", "EOSUSDT", "TUSDUSDT", "IOTAUSDT", "XLMUSDT", "ONTUSDT", "TRXUSDT", "ETCUSDT", "ICXUSDT", "VENUSDT", "NULSUSDT", "VETUSDT", "PAXUSDT", "BCHABCUSDT", "BCHSVUSDT", "USDCUSDT", "LINKUSDT", "WAVESUSDT", "BTTUSDT", "USDSUSDT", "ONGUSDT", "HOTUSDT", "ZILUSDT", "ZRXUSDT", "FETUSDT", "BATUSDT", "XMRUSDT", "ZECUSDT", "IOSTUSDT", "CELRUSDT", "DASHUSDT", "NANOUSDT", "OMGUSDT"};
		while(true) {
			try {
				Thread.sleep(100000);
				for(int i = 0; i < coinNames.length; i++) {
					List<Candlestick> min5 = Collections.synchronizedList(client.getCandlestickBars(coinNames[i], CandlestickInterval.FIVE_MINUTES));
					List<Candlestick> halfHour = Collections.synchronizedList(client.getCandlestickBars(coinNames[i], CandlestickInterval.HALF_HOURLY));
					List<Candlestick> hourly = Collections.synchronizedList(client.getCandlestickBars(coinNames[i], CandlestickInterval.HOURLY));
					List<Candlestick> daily = Collections.synchronizedList(client.getCandlestickBars(coinNames[i], CandlestickInterval.DAILY));
					AllCoins.updateCoin(new CoinClass(coinNames[i],min5,halfHour,hourly,daily,Double.parseDouble(client.getPrice(coinNames[i]).getPrice())));
				}
			}
			catch(InterruptedException ie) {
				System.out.println(ie.getMessage());
			}
		}
	}
}



