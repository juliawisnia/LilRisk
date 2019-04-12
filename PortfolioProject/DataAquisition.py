
#pip install python-binance
from binance.client import Client

class candlestick:

    def __init__(self, currCandle):
        self.openTime = currCandle[0]
        self.closeTime = currCandle[6]
        self. candleOpen = currCandle[1]
        self.candleHigh = currCandle[2]
        self.candleLow = currCandle[3]
        self.candleClose = currCandle[4]
        self.candleVolume = currCandle[5]
        self.quoteAssetVolume = currCandle[7]
        self.numberTrade = currCandle[8]
        self.takerBuyBaseAssetVol = currCandle[9]
        self.takerBuyQuoteAssetVol = currCandle[10]

class coinClass:
    def __init__(self, coinName, allCandleObjects):
        self.name = coinName
        self.allCandleObjects = allCandleObjects


#Initializes keys and links to exchange account
api_key = 'CFQvKQ9Xuf7L6mf8i7qqCoDmrK9C6XzGibUWXvTB4nagC3OblBlMTj49BNHV3qjN'
api_secret = 'PTJVaWQd9DCW2ysn7ATdLf1T9F8eheEe29mEVfIx9BML92N1dC95nk7jfn8tFplM'
client = Client(api_key, api_secret)

TIMEFRAME = Client.KLINE_INTERVAL_1HOUR


parseList = ['BTCUSDT', 'ETHUSDT', 'LTCUSDT', 'EOSUSDT', 'XRPUSDT', 'IOTAUSDT', 'NEOUSDT']
coinList = []
for coin in parseList:
    candleList = client.get_klines(symbol=coin, interval=TIMEFRAME)
    allCandleObjects = []
    for i in range(len(candleList)):
        allCandleObjects.append(candlestick(candleList[(len(candleList) - 2) - i]))
    coinList.append(coinClass(coin, allCandleObjects))

print(coinList)
print(len(coinList))
print(len(allCandleObjects))
recentCandle = coinList[4].allCandleObjects[0]

# =============== Prints information about most recent candle =============== #
print("Candle Open Time: ", recentCandle.openTime)
print("Candle Open Price: ", recentCandle.candleOpen)
print("Candle High: ", recentCandle.candleHigh)
print("Candle Low: ", recentCandle.candleLow)
print("Candle Close Price: ", recentCandle.candleClose)
print("Candle Volume: ", recentCandle.candleVolume)
print("Candle Close Time: ", recentCandle.closeTime)
print("Candle Quote Asset Volume: ", recentCandle.quoteAssetVolume)
print("Candle Number of Trades: ", recentCandle.numberTrade)
print("Candle Taker Buy Base Asset Volume: ", recentCandle.takerBuyBaseAssetVol)
print("Candle Taker Buy Quote Asset Volume: ", recentCandle.takerBuyQuoteAssetVol)