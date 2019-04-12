package coinData;

import java.util.Collections;
import java.util.Hashtable;
import java.util.Map;

public class CoinNamesMap {
	private static Map<String, String> symbol2Names = Collections.synchronizedMap(new Hashtable<String, String>());
	private static Map<String, String> name2Symbols = Collections.synchronizedMap(new Hashtable<String, String>());
	
	public CoinNamesMap() {
		String symbols[] = {"BTCUSDT", "ETHUSDT", "BNBUSDT", "NEOUSDT", "LTCUSDT", "QTUMUSDT", "ADAUSDT", "XRPUSDT", "EOSUSDT", "IOTAUSDT", "XLMUSDT", "ONTUSDT", "TRXUSDT", "ETCUSDT", "ICXUSDT", "NULSUSDT", "VETUSDT", "PAXUSDT", "BCHABCUSDT", "BCHSVUSDT", "LINKUSDT", "WAVESUSDT", "BTTUSDT",  "ONGUSDT", "HOTUSDT", "ZILUSDT", "ZRXUSDT", "FETUSDT", "BATUSDT", "XMRUSDT", "ZECUSDT", "IOSTUSDT", "CELRUSDT", "DASHUSDT", "NANOUSDT", "OMGUSDT"};
		String names[] = {"BITCOIN", "ETHEREUM", "BINANCE COIN", "NEO", "LITECOIN", "QTUM", "CARDANO", "RIPPLE", "EOS", "MIOTA", "STELLAR LUMENS", "ONTOLOGY", "TRON", "ETHEREUM CLASSIC", "ICON", "NULS", "VECHAIN", "PAXOS STANDARD", "BITCOIN CASH ABC", "CHAINLINK", "WAVES", "BITTORRENT", "ONTOLOGY GAS", "HOLO" ,"ZILLIQUA", "0X", "FETCH.AI", "BASIC ATTENTION TOKEN", "MONERO", "ZCASH", "CELER NETWORK", "DASH", "NANO", "OMISEGO"}; 
		for(int i = 0; i < names.length; i++) {
			symbol2Names.put(symbols[i], names[i]);
			name2Symbols.put(names[i], symbols[i]);
		}
	}
	
	public static String symbol2Name(String symbol) {
		return symbol2Names.get(symbol);
	}
	
	public static String name2Symbol(String symbol) {
		return name2Symbols.get(symbol);
	}
}
