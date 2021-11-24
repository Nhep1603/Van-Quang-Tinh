import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:van_quang_tinh/src/models/crypto.dart';
import 'package:van_quang_tinh/src/widgets/coin_search.dart';

import '../../mock_data/crypto_mock_data.dart';

void main() {
  group('Autocomplete testing for coin search', () {
    final mockResponse = json.decode(mockCryptoData);
    final cryptos = List<Crypto>.from( mockResponse.map((model) => Crypto.fromJson(model)));

    test('Should return a name', () {
      expect(CoinSearch.displayStringForOption(cryptos.first), cryptos.first.name);
    });
  });
}