package coinData;

import java.util.Collections;
import java.util.Hashtable;
import java.util.Map;

public class CoinNamesMap {
	private Map<String, String> symbol2Names = Collections.synchronizedMap(new Hashtable<String, String>());
	private Map<String, String> name2Symbols = Collections.synchronizedMap(new Hashtable<String, String>());
	
	public Coinmap() {
		String symbols[] = {"BTCUSDT", "ETHUSDT", "BNBUSDT", "BCCUSDT", "NEOUSDT", "LTCUSDT", "QTUMUSDT", "ADAUSDT", "XRPUSDT", "EOSUSDT", "TUSDUSDT", "IOTAUSDT", "XLMUSDT", "ONTUSDT", "TRXUSDT", "ETCUSDT", "ICXUSDT", "VENUSDT", "NULSUSDT", "VETUSDT", "PAXUSDT", "BCHABCUSDT", "BCHSVUSDT", "USDCUSDT", "LINKUSDT", "WAVESUSDT", "BTTUSDT", "USDSUSDT", "ONGUSDT", "HOTUSDT", "ZILUSDT", "ZRXUSDT", "FETUSDT", "BATUSDT", "XMRUSDT", "ZECUSDT", "IOSTUSDT", "CELRUSDT", "DASHUSDT", "NANOUSDT", "OMGUSDT"};
		String names[] = {"BITCOIN", "ETHERIUM", 
	}
	
	public String symbol2Name(String symbol) {
		
	}
	
	public String name2Symbol(String symbol) {
		
	}
}
