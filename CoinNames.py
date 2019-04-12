
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

tickers = client.get_all_tickers()

coinNames = []

for tick in tickers:
    coin = tick['symbol']
    if coin[-4:] == 'USDT':
        if coin not in coinNames:
            coinNames.append(coin)

print(len(coinNames))
print(coinNames)