class Prices {
  final List<List<dynamic>> prices;

  const Prices({
    required this.prices,
  });

  Map<String, dynamic> toJson() {
    return {
      'prices': prices,
    };
  }

  factory Prices.fromJson(Map<String, dynamic> map) {
    return Prices(
      prices: List<List<dynamic>>.from(map['prices']?.map((x) => x)),
    );
  }
}
