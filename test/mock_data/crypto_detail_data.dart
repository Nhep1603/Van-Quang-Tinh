const String rawBitcoin = r'''{
  "id": "bitcoin",
  "symbol": "btc",
  "name": "Bitcoin",
  "image": {
    "thumb": "https://assets.coingecko.com/coins/images/1/thumb/bitcoin.png?1547033579",
    "small": "https://assets.coingecko.com/coins/images/1/small/bitcoin.png?1547033579",
    "large": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579"
  },
  "market_data": {
    "current_price": {
      "usd": 57778
    },
    "price_change_percentage_24h": 2.49494
  }
}''';

const String rawBitcoinWithNegativePriceChangePercentage24h = r'''{
  "id": "bitcoin",
  "symbol": "btc",
  "name": "Bitcoin",
  "image": {
    "thumb": "https://assets.coingecko.com/coins/images/1/thumb/bitcoin.png?1547033579",
    "small": "https://assets.coingecko.com/coins/images/1/small/bitcoin.png?1547033579",
    "large": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579"
  },
  "market_data": {
    "current_price": {
      "usd": 57778
    },
    "price_change_percentage_24h": -2.49494
  }
}''';
