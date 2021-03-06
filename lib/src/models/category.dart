import 'package:equatable/equatable.dart';

import '../constants/constants.dart' as constants;

class Category extends Equatable {
  final String id;
  final String name;
  final num marketCap;
  final num marketCapChange24h;

  const Category({
    required this.id,
    required this.name,
    required this.marketCap,
    required this.marketCapChange24h,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'market_cap': marketCap,
      'market_cap_change_24h': marketCapChange24h,
    };
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'] ?? constants.StringConstant.textForNullNameField,
      marketCap: json['market_cap'],
      marketCapChange24h: json['market_cap_change_24h'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        marketCap,
        marketCapChange24h,
      ];
}
