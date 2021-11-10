import 'package:equatable/equatable.dart';

class Crypto extends Equatable {
  final String? id;
  final String? symbol;
  final String? name;
  final String? image;
  final int? currentPrice;
  final int? marketCap;
  final int? marketCapRank;
  final double? priceChangePercentage24h;

  const Crypto({
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCap,
    this.marketCapRank,
    this.priceChangePercentage24h,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'image': image,
      'current_price': currentPrice,
      'market_cap': marketCap,
      'market_cap_rank': marketCapRank,
      'price_change_percentage_24h': priceChangePercentage24h,
    };
  }

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      image: json['image'],
      currentPrice: json['current_price'],
      marketCap: json['market_cap'],
      marketCapRank: json['market_cap_rank'],
      priceChangePercentage24h: json['price_change_percentage_24h'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        symbol,
        name,
        image,
        currentPrice,
        marketCap,
        marketCapRank,
        priceChangePercentage24h,
      ];
}
