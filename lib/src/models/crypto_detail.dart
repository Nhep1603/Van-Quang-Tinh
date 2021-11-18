import 'package:equatable/equatable.dart';

class CryptoDetail extends Equatable {
  final String id;
  final String symbol;
  final String name;
  final CryptoImage image;
  final CryptoMarketData marketData;

  const CryptoDetail({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.marketData,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'image': image.toJson(),
      'market_data': marketData.toJson(),
    };
  }

  factory CryptoDetail.fromJson(Map<String, dynamic> map) {
    return CryptoDetail(
      id: map['id'],
      symbol: map['symbol'],
      name: map['name'],
      image: CryptoImage.fromJson(map['image']),
      marketData: CryptoMarketData.fromJson(map['market_data']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        symbol,
        name,
        image,
        marketData,
      ];
}

class CryptoImage extends Equatable {
  final String small;

  const CryptoImage({
    required this.small,
  });

  Map<String, dynamic> toJson() {
    return {
      'small': small,
    };
  }

  factory CryptoImage.fromJson(Map<String, dynamic> map) {
    return CryptoImage(
      small: map['small'],
    );
  }

  @override
  List<Object?> get props => [small];
}

class CryptoMarketData extends Equatable {
  final CryptoCurrentPrice currentPrice;
  final double priceChangePercentage24h;

  const CryptoMarketData({
    required this.currentPrice,
    required this.priceChangePercentage24h,
  });

  Map<String, dynamic> toJson() {
    return {
      'current_price': currentPrice.toJson(),
      'price_change_percentage_24h': priceChangePercentage24h,
    };
  }

  factory CryptoMarketData.fromJson(Map<String, dynamic> map) {
    return CryptoMarketData(
      currentPrice: CryptoCurrentPrice.fromJson(map['current_price']),
      priceChangePercentage24h: map['price_change_percentage_24h'],
    );
  }

  @override
  List<Object?> get props => [
        currentPrice,
        priceChangePercentage24h,
      ];
}

class CryptoCurrentPrice extends Equatable {
  final int usd;

  const CryptoCurrentPrice({
    required this.usd,
  });

  Map<String, dynamic> toJson() {
    return {
      'usd': usd,
    };
  }

  factory CryptoCurrentPrice.fromJson(Map<String, dynamic> map) {
    return CryptoCurrentPrice(
      usd: map['usd'],
    );
  }

  @override
  List<Object?> get props => [usd];
}
