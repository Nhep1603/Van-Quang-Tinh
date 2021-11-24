import './category.dart';
import './crypto.dart';

var dataCrypto = [
  const Crypto(
      id: 'bitcoin',
      name: 'Bitcoin',
      symbol: 'BTC',
      image: 'assets/images/bitcoin_symbol.png',
      currentPrice: 6244545187,
      marketCap: 11792271952844,
      marketCapRank: 1,
      priceChangePercentage24h: -1.0),
  const Crypto(
      id: 'ethereum',
      name: 'Ethereum',
      symbol: 'ETH',
      image: 'assets/images/bitcoin_symbol.png',
      currentPrice: 455161,
      marketCap: 539494258756,
      marketCapRank: 2,
      priceChangePercentage24h: -0.8),
  const Crypto(
      id: 'binancecoin',
      name: 'Binance Coin"',
      symbol: 'BNC',
      image: 'assets/images/bitcoin_symbol.png',
      currentPrice: 63483,
      marketCap: 107029922901,
      marketCapRank: 3,
      priceChangePercentage24h:  3.0888),
  const Crypto(
      id: 'tether',
      name: 'Tether',
      symbol: 'USDT',
      image: 'assets/images/bitcoin_symbol.png',
      currentPrice: 10,
      marketCap: 74972785921,
      marketCapRank: 4,
      priceChangePercentage24h:  0.92313),
];

var data = [
  const Category(
    id : "1",
    name: "Smart Contract Platform",
    marketCap: 855333835639.5118,
    marketCapChange24h: 2.328850515292989
  ),
  const Category(
    id : "2",
    name: "Exchange-based Tokens",
    marketCap: 0,
    marketCapChange24h: -3.934820635864761
  ),
  const Category(
    id : "3",
    name: "Decentralized Finance (DeFi)",
    marketCap: 172812484359.5981,
    marketCapChange24h: 0
  ),
  const Category(
    id : "4",
    name: "Centralized Exchange Token (CEX)",
    marketCap: 140528970744.39716,
    marketCapChange24h: -4.029343583135189
  ),
  const Category(
    id : "5",
    name: "Smart Contract Platform",
    marketCap: 855333835639.5118,
    marketCapChange24h: 2.328850515292989
  ),
  const Category(
        id : "6",
        name : "Solana Ecosystem",
        marketCap: 108232497382.02513,
        marketCapChange24h : -1.0360337696033184
  ),
    const Category(
        id : "7",
        name : "Polkadot Ecosystem",
        marketCap: 80705212733.64114,
        marketCapChange24h : 5.179757875020746
    ),
    const Category(
        id : "8",
        name : "Polygon Ecosystem",
        marketCap: 70590955262.91747,
        marketCapChange24h : 2.8998757064589533
    ),
    const Category(
        id : "9",
        name : "Meme Tokens",
        marketCap: 70479407734.33675,
        marketCapChange24h : 4.278426649600253
    ),
    const Category(
        id : "10",
        name : "Cosmos Ecosystem",
        marketCap: 59247044788.64026,
        marketCapChange24h : -4.624540393100583
    ),
    const Category(
        id : "11",
        name : "Governance",
        marketCap: 46593310087.76287,
        marketCapChange24h : -5.0547639214546765
    ),
    const Category(
        id : "12",
        name : "Decentralized Exchange Token (DEX)",
        marketCap: 43889624160.2172,
        marketCapChange24h : 2.4126417448149234
    ),
    const Category(
        id : "13",
        name : "Yield Farming",
        marketCap: 40558042646.38619,
        marketCapChange24h : -5.792924206181595
    ),
    const Category(
        id : "14",
        name : "Near Protocol Ecosystem",
        marketCap: 37478831030.955215,
        marketCapChange24h : -3.968938171241379
    ),
    const Category(
        id : "15",
        name : "xDAI Ecosystem",
        marketCap: 31200534747.805313,
        marketCapChange24h : -2.9832167806035237
    )
];