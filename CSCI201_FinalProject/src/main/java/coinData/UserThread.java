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
		
		String coinNames[] = {"BTCUSDT", "ETHUSDT", "BNBUSDT", "NEOUSDT", "LTCUSDT", "QTUMUSDT", "ADAUSDT", "XRPUSDT", "EOSUSDT", "IOTAUSDT", "XLMUSDT", "ONTUSDT", "TRXUSDT", "ETCUSDT", "ICXUSDT", "NULSUSDT", "VETUSDT", "PAXUSDT", "BCHABCUSDT", "BCHSVUSDT", "LINKUSDT", "WAVESUSDT", "BTTUSDT",  "ONGUSDT", "HOTUSDT", "ZILUSDT", "ZRXUSDT", "FETUSDT", "BATUSDT", "XMRUSDT", "ZECUSDT", "IOSTUSDT", "CELRUSDT", "DASHUSDT", "NANOUSDT", "OMGUSDT"};
		for(int i = 0; i < coinNames.length; i++) {
			long dayTime = 1;
			dayTime = dayTime*24*60*60*1000;
			List<Candlestick> day = Collections.synchronizedList(client.getCandlestickBars(coinNames[i], CandlestickInterval.THREE_MINUTES, 500, System.currentTimeMillis()-dayTime,System.currentTimeMillis()));
			List<Candlestick> week = Collections.synchronizedList(client.getCandlestickBars(coinNames[i], CandlestickInterval.HALF_HOURLY, 500,System.currentTimeMillis()-(dayTime*7),System.currentTimeMillis()));
			List<Candlestick> month = Collections.synchronizedList(client.getCandlestickBars(coinNames[i], CandlestickInterval.TWO_HOURLY, 500,System.currentTimeMillis()-(dayTime*30),System.currentTimeMillis()));
			List<Candlestick> month6 = Collections.synchronizedList(client.getCandlestickBars(coinNames[i], CandlestickInterval.TWELVE_HOURLY, 500,System.currentTimeMillis()-(dayTime*30*6),System.currentTimeMillis()));
			List<Candlestick> year = Collections.synchronizedList(client.getCandlestickBars(coinNames[i], CandlestickInterval.DAILY, 500,System.currentTimeMillis()-(dayTime*365),System.currentTimeMillis()));
			AllCoins.addCoin(new CoinClass(coinNames[i],day,week,month,month6,year,Double.parseDouble(client.getPrice(coinNames[i]).getPrice()),Double.parseDouble(client.get24HrPriceStatistics(coinNames[i]).getPriceChangePercent())));
		}
	}
	
	public void run() {
		String key = "CFQvKQ9Xuf7L6mf8i7qqCoDmrK9C6XzGibUWXvTB4nagC3OblBlMTj49BNHV3qjN";
		String secret = "PTJVaWQd9DCW2ysn7ATdLf1T9F8eheEe29mEVfIx9BML92N1dC95nk7jfn8tFplM";
		BinanceApiClientFactory factory = BinanceApiClientFactory.newInstance(key, secret);
		BinanceApiRestClient client = factory.newRestClient();
		
		String coinNames[] = {"BTCUSDT", "ETHUSDT", "BNBUSDT", "NEOUSDT", "LTCUSDT", "QTUMUSDT", "ADAUSDT", "XRPUSDT", "EOSUSDT", "IOTAUSDT", "XLMUSDT", "ONTUSDT", "TRXUSDT", "ETCUSDT", "ICXUSDT", "NULSUSDT", "VETUSDT", "PAXUSDT", "BCHABCUSDT", "BCHSVUSDT", "LINKUSDT", "WAVESUSDT", "BTTUSDT",  "ONGUSDT", "HOTUSDT", "ZILUSDT", "ZRXUSDT", "FETUSDT", "BATUSDT", "XMRUSDT", "ZECUSDT", "IOSTUSDT", "CELRUSDT", "DASHUSDT", "NANOUSDT", "OMGUSDT"};
		while(true) {
			try {
				Thread.sleep(100000);
				for(int i = 0; i < coinNames.length; i++) {
					long dayTime = 1;
					dayTime = dayTime*24*60*60*1000;
					List<Candlestick> day = Collections.synchronizedList(client.getCandlestickBars(coinNames[i], CandlestickInterval.THREE_MINUTES, 500, System.currentTimeMillis()-dayTime,System.currentTimeMillis()));
					List<Candlestick> week = Collections.synchronizedList(client.getCandlestickBars(coinNames[i], CandlestickInterval.HALF_HOURLY, 500,System.currentTimeMillis()-(dayTime*7),System.currentTimeMillis()));
					List<Candlestick> month = Collections.synchronizedList(client.getCandlestickBars(coinNames[i], CandlestickInterval.TWO_HOURLY, 500,System.currentTimeMillis()-(dayTime*30),System.currentTimeMillis()));
					List<Candlestick> month6 = Collections.synchronizedList(client.getCandlestickBars(coinNames[i], CandlestickInterval.TWELVE_HOURLY, 500,System.currentTimeMillis()-(dayTime*30*6),System.currentTimeMillis()));
					List<Candlestick> year = Collections.synchronizedList(client.getCandlestickBars(coinNames[i], CandlestickInterval.DAILY, 500,System.currentTimeMillis()-(dayTime*365),System.currentTimeMillis()));
					AllCoins.updateCoin(new CoinClass(coinNames[i],day,week,month,month6,year,Double.parseDouble(client.getPrice(coinNames[i]).getPrice()),Double.parseDouble(client.get24HrPriceStatistics(coinNames[i]).getPriceChangePercent())));
				}
			}
			catch(InterruptedException ie) {
				System.out.println(ie.getMessage());
			}
		}
	}
}



